import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/domain/booking/repositories/booking_repository.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_event.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc(this.bookingRepository) : super(BookingInitial()) {
    on<LoadBookingsEvent>(_onLoadBookings);
    on<SelectDateEvent>(_onSelectDate);
    on<BookRoomEvent>(_onBookRoom);
  }

  void _onLoadBookings(LoadBookingsEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final bookings = await bookingRepository.loadBookings();
      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError('Failed to load bookings: $e'));
    }
  }

  void _onSelectDate(SelectDateEvent event, Emitter<BookingState> emit) {
    emit(DateSelected(event.selectedDate));
  }

  void _onBookRoom(BookRoomEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      await bookingRepository.bookRoom(event.category, event.index, event.date);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailure('Failed to book room: $e'));
    }
  }
}
