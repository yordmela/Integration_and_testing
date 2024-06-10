import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart';


abstract class FeedbackRepository {
  Future<void> submitFeedback(Feedback feedback);
  Future<List<Feedback>> getFeedbackList();
}
