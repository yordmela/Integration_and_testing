class Booking {
  final String id;
  final String roomName;
  final DateTime bookingDate;
  final String userId;

  Booking({
    required this.id,
    required this.roomName,
    required this.bookingDate,
    required this.userId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'] is String ? json['_id'] : json['_id'].toString(),
      roomName: json['roomName'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'roomName': roomName,
      'bookingDate': bookingDate.toIso8601String(),
      'userId': userId,
    };
  }
}
