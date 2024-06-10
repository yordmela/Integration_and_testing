abstract class BookingEvent {}

class LoadBookingsEvent extends BookingEvent {}

class SelectDateEvent extends BookingEvent {
  final DateTime selectedDate;
  SelectDateEvent(this.selectedDate);
}

class BookRoomEvent extends BookingEvent {
  final Map<String, dynamic> category;
  final int index;
  final DateTime date;
  BookRoomEvent(this.category, this.index, this.date);
}
