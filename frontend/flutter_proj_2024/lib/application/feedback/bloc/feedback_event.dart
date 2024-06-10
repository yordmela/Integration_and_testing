import 'package:equatable/equatable.dart';
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart' as CustomFeedback;

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class SubmitFeedbackEvent extends FeedbackEvent {
  final CustomFeedback.Feedback feedback;

  const SubmitFeedbackEvent(this.feedback);

  @override
  List<Object> get props => [feedback];
}

class LoadFeedbackEvent extends FeedbackEvent {}
