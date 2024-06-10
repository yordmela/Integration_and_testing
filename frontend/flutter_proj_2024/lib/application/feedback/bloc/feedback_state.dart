import 'package:equatable/equatable.dart';
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart' as CustomFeedback;

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackLoadSuccess extends FeedbackState {
  final List<CustomFeedback.Feedback> feedbackList;

  const FeedbackLoadSuccess(this.feedbackList);

  @override
  List<Object> get props => [feedbackList];
}

class FeedbackFailure extends FeedbackState {
  final String message;

  const FeedbackFailure(this.message);

  @override
  List<Object> get props => [message];
}
