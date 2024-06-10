// src/booking/dto/create-booking.dto.ts
import { IsNotEmpty, IsString, IsNumber, IsDateString } from 'class-validator';

export class CreateBookingDto {
  @IsNotEmpty()
  @IsString()
  title: string;

  @IsNotEmpty()
  @IsString()
  image: string;

  @IsNotEmpty()
  @IsString()
  description: string;

  @IsNotEmpty()
  @IsNumber()
  price: number;

  @IsDateString()
  bookingDate: Date;
}
