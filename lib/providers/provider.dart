import 'package:flutter/cupertino.dart';
import 'package:flutter_survey/models/dummy_data.dart';
import 'package:flutter_survey/models/question_model.dart';

//
//Provider for  Question State Mgmt

class QuestionState with ChangeNotifier {
  List<QuestionModel> _questions;
  Map<int, dynamic> _answers = {};
  int currentIndex = 0;

  void loadQuestionsList( ) async {
    _questions = getQuestionsList();
    notifyListeners();
  }

//returning a copy of the list
  List<QuestionModel> get questions {
    return [..._questions];
  }

  void onChanged(){
    notifyListeners();
  }

  Map<int, dynamic> get answers {
    return _answers;
  }

  void clearSelection() {
    _answers.clear();
    notifyListeners();
  }
// // get the item index and return
//   int get getIndex => currentIndex;

  void nextIndex() {
    currentIndex += 1;
    notifyListeners();
  }

  void lastIndex() {
    currentIndex -= 1;
    notifyListeners();
  }
}
