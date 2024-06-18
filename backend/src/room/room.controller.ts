import { Body, Controller, Delete, Get, Param, Post, Put, Req, UseGuards, UseInterceptors, UploadedFile } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { RoomService } from './room.service';
import { Room } from './schemas/room.schema';
import { CreateRoomDto } from './dto/create-room.dto';
import { UpdateRoomDto } from './dto/update-room.dto';
import { AuthGuard } from '@nestjs/passport';
import { Roles } from 'src/auth/roles.decorator';
import { RolesGuard } from 'src/auth/roles.guard';
import { Role } from 'src/auth/user/schemas/user.schema';

@Controller('room')
export class RoomController {
  constructor(private roomService: RoomService) {}

  @Get()
  async getAllRooms(): Promise<Room[]> {
    const rooms = await this.roomService.findAll();
    // Add base URL to image paths
    rooms.forEach(room => {
      if (room.image) {
        room.image = `http://localhost:3000/uploads/${room.image}`;
      }
    });
    console.log('Room', rooms)
    return rooms;
  }

  @Post()
@UseGuards(AuthGuard(), RolesGuard)
@Roles(Role.Admin)
@UseInterceptors(FileInterceptor('image', {
  storage: diskStorage({
    destination: './uploads',
    filename: (req, file, cb) => {
      const randomName = Array(32).fill(null).map(() => (Math.round(Math.random() * 16)).toString(16)).join('');
      cb(null, `${randomName}${extname(file.originalname)}`);
    },
  }),
}))
async createRoom(
  @UploadedFile() file: Express.Multer.File,
  @Body() body: any,
  @Req() req
): Promise<Room> {
  console.log('Body:', body);
  console.log('File:', file);
  console.log('User:', req.user);
  
  const createRoomDto: CreateRoomDto = {
    title: body.title,
    description: body.description,
    price: parseFloat(body.price), // Ensure the price is parsed as a number
    category: body.category,
    user: req.user,
    image: file ? file.filename : null,
  };
  
  return this.roomService.create(createRoomDto, req.user);
}


  @Get(':id')
  async getRoom(
    @Param('id') id: string,
  ): Promise<Room> {
    return this.roomService.findById(id);
  }

  @Put(':id')
  @Roles(Role.Admin)
  @UseGuards(AuthGuard(), RolesGuard)
  @UseInterceptors(FileInterceptor('image', {
    storage: diskStorage({
      destination: './uploads',
      filename: (req, file, cb) => {
        const randomName = Array(32).fill(null).map(() => (Math.round(Math.random() * 16)).toString(16)).join('');
        cb(null, `${randomName}${extname(file.originalname)}`);
      },
    }),
  }))
  async updateRoom(
    @UploadedFile() file: Express.Multer.File,
    @Param('id') id: string,
    @Body() body: any,
    @Req() req
  ): Promise<Room> {
    const updateRoomDto: UpdateRoomDto = {
      title: body.title,
      description: body.description,
      price: parseFloat(body.price), // Ensure the price is parsed as a number
      category: body.category,
      user: req.user,
      image: file ? file.filename : null,
    };
    return this.roomService.updateById(id, updateRoomDto, req.user);
  }


  @Delete(':id')
  @Roles(Role.Admin)
  @UseGuards(AuthGuard(), RolesGuard)
  async deleteRoom(
    @Param('id') id: string,
    @Req() req
  ): Promise<Room> {
    return this.roomService.deleteById(id, req.user);
  }
}
