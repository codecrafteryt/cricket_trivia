  // Model for Quiz Questions
  class QuizQuestion {
    final String question;
    final List<String> options;
    final int correctAnswerIndex;
    final String? imagePath; // Optional image for each question

    QuizQuestion({
      required this.question,
      required this.options,
      required this.correctAnswerIndex,
      this.imagePath,
    });
  }