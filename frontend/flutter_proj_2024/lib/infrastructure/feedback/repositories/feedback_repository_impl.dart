
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart' as CustomFeedback;
import 'package:flutter_proj_2024/domain/feedback/repositories/feedback_repository.dart';
import 'package:flutter_proj_2024/infrastructure/feedback/data_sources/feedback_remote_data_source.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitFeedback(CustomFeedback.Feedback feedback) async {
    await remoteDataSource.submitFeedback(feedback);
  }

  @override
  Future<List<CustomFeedback.Feedback>> getFeedbackList() async {
    return await remoteDataSource.getFeedbackList();
  }
}
