class QuizModel {
  final String id;
  final String questionNp;
  final List<String> optionsNp;
  final int correctIndex;
  final String explanationNp;
  final String fraudType;
  final String difficulty;

  const QuizModel({
    required this.id,
    required this.questionNp,
    required this.optionsNp,
    required this.correctIndex,
    required this.explanationNp,
    required this.fraudType,
    required this.difficulty,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    id: json['id'] as String,
    questionNp: json['question_np'] as String,
    optionsNp: List<String>.from(json['options_np'] as List),
    correctIndex: json['correct_index'] as int,
    explanationNp: json['explanation_np'] as String,
    fraudType: json['fraud_type'] as String,
    difficulty: json['difficulty'] as String,
  );
}

class QuizResultModel {
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final DateTime completedAt;

  const QuizResultModel({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.completedAt,
  });

  int get percentage => ((correctAnswers / totalQuestions) * 100).round();

  String get grade {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    return 'D';
  }
}
