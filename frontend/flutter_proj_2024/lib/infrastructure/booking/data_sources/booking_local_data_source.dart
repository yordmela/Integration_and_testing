import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:mongo_dart/mongo_dart.dart';

class BookingLocalDataSource {
  final DbCollection bookingCollection;

  BookingLocalDataSource(this.bookingCollection);

  Future<List<Booking>> getBookings() async {
    final bookings = await bookingCollection.find().toList();
    return bookings.map((json) => Booking.fromJson(json)).toList();
  }

  Future<void> addBooking(Booking booking) async {
    await bookingCollection.insertOne(booking.toJson());
  }

  Future<void> updateBooking(Booking booking) async {
    await bookingCollection.update(
      where.eq('_id', ObjectId.fromHexString(booking.id)),
      booking.toJson(),
    );
  }

  Future<void> deleteBooking(Booking booking) async {
    await bookingCollection.deleteOne(where.eq('_id', ObjectId.fromHexString(booking.id)));
  }
}
