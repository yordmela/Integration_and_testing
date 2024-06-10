// src/booking/booking.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Booking } from './schema/booking.schema';
import { CreateBookingDto } from './dto/create-booking.dto';
import { UpdateBookingDto } from './dto/update-booking.dto';

@Injectable()
export class BookingService {
  constructor(
    @InjectModel(Booking.name) private readonly bookingModel: Model<Booking>
  ) {}

  async findAll(): Promise<Booking[]> {
    return this.bookingModel.find().populate('user').exec();
  }

  async findById(id: string): Promise<Booking> {
    const booking = await this.bookingModel.findById(id).populate('user').exec();
    if (!booking) {
      throw new NotFoundException('Booking not found');
    }
    return booking;
  }

  async create(createBookingDto: CreateBookingDto, userId: string): Promise<Booking> {
    const booking = new this.bookingModel({ ...createBookingDto, user: userId });
    return booking.save();
  }

  async updateById(id: string, updateBookingDto: UpdateBookingDto): Promise<Booking> {
    const updatedBooking = await this.bookingModel.findByIdAndUpdate(id, updateBookingDto, { new: true }).exec();
    if (!updatedBooking) {
      throw new NotFoundException('Booking not found');
    }
    return updatedBooking;
  }

  async deleteById(id: string): Promise<void> {
    const result = await this.bookingModel.findByIdAndDelete(id).exec();
    if (!result) {
      throw new NotFoundException('Booking not found');
    }
  }
}
