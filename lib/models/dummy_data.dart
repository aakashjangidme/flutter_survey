
import 'package:flutter_survey/models/question_model.dart';

List<QuestionModel> getQuestionsList() {
  List<QuestionModel> questionList = List<QuestionModel>();

  questionList.add(
    QuestionModel(
        id: 1,
        questiontext: 'Best Mobile App Framework',
        answertext: ['Flutter', 'React Native', 'Ionic', 'Blah']),
  );

  questionList.add(
    QuestionModel(
        id: 1,
        questiontext: 'Best Web App Framework',
        answertext: ['Django', 'React', 'Angular', 'Blah']),
  );

  
  questionList.add(
    QuestionModel(
        id: 1,
        questiontext: 'Burraaah oye',
        answertext: ['Django', 'React', 'Angular', 'Blah']),
  );

  return questionList;
}
