// src/booking/booking.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param, Req, UseGuards } from '@nestjs/common';
import { BookingService } from './booking.service';
import { CreateBookingDto } from './dto/create-booking.dto';
import { UpdateBookingDto } from './dto/update-booking.dto';
import { AuthGuard } from '@nestjs/passport';
import { RolesGuard } from 'src/auth/roles.guard';
import { Roles } from 'src/auth/roles.decorator';
import { Role } from 'src/auth/user/schemas/user.schema';

@Controller('bookings')
export class BookingController {
  constructor(private readonly bookingService: BookingService) {}

  @Get()
  @UseGuards(AuthGuard(), RolesGuard)
  @Roles(Role.Customer)
  async findAll() {
    return this.bookingService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return this.bookingService.findById(id);
  }

  @Post()
  @UseGuards(AuthGuard(), RolesGuard)
  @Roles(Role.Customer)
  async create(@Body() createBookingDto: CreateBookingDto, @Req() req) {
    return this.bookingService.create(createBookingDto, req.user._id);
  }

  @Put(':id')
  @UseGuards(AuthGuard(), RolesGuard)
  @Roles(Role.Customer)
  async update(@Param('id') id: string, @Body() updateBookingDto: UpdateBookingDto) {
    return this.bookingService.updateById(id, updateBookingDto);
  }

  @Delete(':id')
  @UseGuards(AuthGuard(), RolesGuard)
  @Roles(Role.Customer)
  async delete(@Param('id') id: string) {
    return this.bookingService.deleteById(id);
  }
}
