import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart' as CustomFeedback;

class FeedbackRemoteDataSource {
  final String baseUrl = 'http://localhost:3000/feedback'; // Replace with your actual backend URL

  Future<void> submitFeedback(CustomFeedback.Feedback feedback) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'customerName': feedback.customerName,
        'message': feedback.message,
        'rating': feedback.rating,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to submit feedback');
    }
  }

  Future<List<CustomFeedback.Feedback>> getFeedbackList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> feedbackData = jsonDecode(response.body);
      return feedbackData.map((json) => CustomFeedback.Feedback.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feedback list');
    }
  }
}
