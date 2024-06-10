import 'package:bloc/bloc.dart';
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart' as CustomFeedback;
import 'package:flutter_proj_2024/domain/feedback/repositories/feedback_repository.dart';
import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository feedbackRepository;

  FeedbackBloc({required this.feedbackRepository}) : super(FeedbackInitial()) {
    on<SubmitFeedbackEvent>(_onSubmitFeedbackEvent);
    on<LoadFeedbackEvent>(_onLoadFeedbackEvent);
  }

  Future<void> _onSubmitFeedbackEvent(
    SubmitFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    try {
      await feedbackRepository.submitFeedback(event.feedback);
      final feedbackList = await feedbackRepository.getFeedbackList();
      emit(FeedbackLoadSuccess(feedbackList));
    } catch (e) {
      emit(FeedbackFailure(e.toString()));
    }
  }

  Future<void> _onLoadFeedbackEvent(
    LoadFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    try {
      final feedbackList = await feedbackRepository.getFeedbackList();
      emit(FeedbackLoadSuccess(feedbackList));
    } catch (e) {
      emit(FeedbackFailure(e.toString()));
    }
  }
}
