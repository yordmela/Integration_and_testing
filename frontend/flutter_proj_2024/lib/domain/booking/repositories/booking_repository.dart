import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> loadBookings();
  Future<void> bookRoom(Map<String, dynamic> category, int index, DateTime date);
  Future<void> updateBooking(Booking booking);
  Future<void> deleteBooking(Booking booking);
}
