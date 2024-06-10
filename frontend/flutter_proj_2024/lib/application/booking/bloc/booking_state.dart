import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
// import 'package:flutter_proj_2024/domain/booking/usecases/get_bookings.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<Booking> bookings;
  BookingLoaded(this.bookings);
}

class BookingError extends BookingState {
  final String errorMessage;
  BookingError(this.errorMessage);
}

class DateSelected extends BookingState {
  final DateTime selectedDate;
  DateSelected(this.selectedDate);
}

class BookingSuccess extends BookingState {}

class BookingFailure extends BookingState {
  final String errorMessage;
  BookingFailure(this.errorMessage);
}
