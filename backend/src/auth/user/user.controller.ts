import { Controller, Get, Put, Post, Body, UseGuards, Param, Delete, UnauthorizedException, Req } from '@nestjs/common';
import { UsersService } from './user.service';
import { Roles } from '../roles.decorator';
import { RolesGuard } from '../roles.guard';
import { Role, User } from './schemas/user.schema';
import { AuthGuard } from '@nestjs/passport';


@Controller('users')
export class UserController {
  constructor(private readonly userService: UsersService) {}

  @Get()
  @Roles(Role.Admin)
  @UseGuards(AuthGuard(), RolesGuard)
  async findAllUsers(): Promise<User[]> {
    return this.userService.findAll();
  }

  @Get(':id')
  @Roles(Role.Admin)
  @UseGuards(AuthGuard(), RolesGuard)
  async findOneById(@Param('id') id: string): Promise<User | null> {
    return this.userService.findOneById(id);
  }

  @Put(':id/name')
  @UseGuards(AuthGuard())
  async updateUserName(@Param('id') id: string, @Body('name') name: string): Promise<User> {
    return this.userService.updateUserName(id, name);
  }

  @Put(':id/password')
  @UseGuards(AuthGuard())
  async updateUserPassword(@Param('id') id: string, @Body('password') password: string): Promise<User> {
    return this.userService.updateUserPassword(id, password);
  }

  @Delete(':id')
  @Roles(Role.Admin)
  @UseGuards(AuthGuard(), RolesGuard)
  async deleteUserById(@Param('id') id: string): Promise<User | null> {
    return this.userService.deleteUserById(id);
  }

  @Delete('self/:id')
  @UseGuards(AuthGuard())
  async deleteOwnAccount(@Param('id') id: string, @Req() req): Promise<User | null> {
    const user = req.user;
    if (user.id !== id) {
      throw new UnauthorizedException('You can only delete your own account');
    }
    return this.userService.deleteUserById(id);
  }
}
