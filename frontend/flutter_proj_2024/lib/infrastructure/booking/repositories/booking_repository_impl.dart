import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/domain/booking/repositories/booking_repository.dart';
import 'package:flutter_proj_2024/infrastructure/booking/data_sources/booking_local_data_source.dart';
import 'package:mongo_dart/mongo_dart.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource dataSource;

  BookingRepositoryImpl(this.dataSource);

  @override
  Future<List<Booking>> loadBookings() async {
    return await dataSource.getBookings();
  }

  @override
  Future<void> bookRoom(Map<String, dynamic> category, int index, DateTime date) async {
    final booking = Booking(
      id: ObjectId().toHexString(), // Generate a new ID
      roomName: category['title'],
      bookingDate: date,
      userId: 'currentUserId', // Replace with the current user's ID
    );
    await dataSource.addBooking(booking);
  }

  @override
  Future<void> updateBooking(Booking booking) async {
    await dataSource.updateBooking(booking);
  }

  @override
  Future<void> deleteBooking(Booking booking) async {
    await dataSource.deleteBooking(booking);
  }
}
