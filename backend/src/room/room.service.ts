import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from "@nestjs/mongoose";
import * as mongoose from "mongoose";
import { Room } from './schemas/room.schema';
import { User } from 'src/auth/user/schemas/user.schema';
import { CreateRoomDto } from './dto/create-room.dto';
import { UpdateRoomDto } from './dto/update-room.dto';

@Injectable()
export class RoomService {
    constructor(
        @InjectModel(Room.name)
        private roomModel: mongoose.Model<Room>
    ) {}

    async findAll(): Promise<Room[]> {
        const rooms = await this.roomModel.find().populate('user');
        return rooms;
    }

    async create(roomDto: CreateRoomDto, user: User): Promise<Room> {
        const room = {
            ...roomDto,
            user: user._id
        };
        const createdRoom = await this.roomModel.create(room);
        return createdRoom;
    }

    async findById(id: string): Promise<Room> {
        const isValidId = mongoose.isValidObjectId(id);
        if (!isValidId) {
            throw new BadRequestException('Please insert a valid ID.');
        }
        const room = await this.roomModel.findById(id).populate('user');
        if (!room) {
            throw new NotFoundException('Room not found.');
        }
        return room;
    }

    async updateById(id: string, roomDto: UpdateRoomDto, user: User): Promise<Room> {
        const updateData = {
            ...roomDto,
            user: user._id
        };
        const updatedRoom = await this.roomModel.findByIdAndUpdate(id, updateData, {
            new: true,
            runValidators: true
        });
        if (!updatedRoom) {
            throw new NotFoundException('Room not found.');
        }
        return updatedRoom;
    }

    async deleteById(id: string, user: User): Promise<Room> {
        const deletedRoom = await this.roomModel.findByIdAndDelete(id);
        if (!deletedRoom) {
            throw new NotFoundException('Room not found.');
        }
        return deletedRoom;
    }
}
