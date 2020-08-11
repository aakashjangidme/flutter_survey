

class QuestionModel {
  QuestionModel({
    this.answerText,
    this.questionText,
  });

  List<dynamic> answerText;
  String questionText;

  static QuestionModel fromMap(Map<String, dynamic> map,) {
    if (map == null) return null;

    return QuestionModel(answerText: map['answerText'],
    questionText: map['questionText'],
    );
  }
}
