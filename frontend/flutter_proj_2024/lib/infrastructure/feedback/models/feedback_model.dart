import 'package:equatable/equatable.dart';

class Feedback extends Equatable {
  final String id;
  final String customerName;
  final String message;
  final int rating;  // Ensure this is included
  final DateTime createdAt;

  const Feedback({
    required this.id,
    required this.customerName,
    required this.message,
    required this.rating,  // Ensure this is included
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, customerName, message, rating, createdAt];

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'] as String,
      customerName: json['customerName'] as String,
      message: json['message'] as String,
      rating: json['rating'] as int,  // Ensure this is included
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'message': message,
      'rating': rating,  // Ensure this is included
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
