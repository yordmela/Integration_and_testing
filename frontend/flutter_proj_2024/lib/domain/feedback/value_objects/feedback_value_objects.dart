class FeedbackMessage {
  final String value;

  FeedbackMessage(this.value) {
    if (value.isEmpty) {
      throw Exception('Feedback message cannot be empty');
    }
  }
}

class UserName {
  final String value;

  UserName(this.value) {
    if (value.isEmpty) {
      throw Exception('User name cannot be empty');
    }
  }
}

class FeedbackRating {
  final int value;

  FeedbackRating(this.value) {
    if (value < 1 || value > 5) {
      throw Exception('Rating must be between 1 and 5');
    }
  }
}
