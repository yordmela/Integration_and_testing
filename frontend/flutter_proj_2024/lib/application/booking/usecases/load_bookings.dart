import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/domain/booking/repositories/booking_repository.dart';

class GetBooking {
  final BookingRepository bookingRepository;

  GetBooking(this.bookingRepository);

  Future<List<Booking>> call() async {
    return await bookingRepository.loadBookings();
  }
}
