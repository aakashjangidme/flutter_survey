import 'package:flutter/cupertino.dart';
import 'package:flutter_survey/models/question_model.dart';
import 'package:flutter_survey/models/service.dart';

//
//Provider for  Question State Mgmt

class QuestionState with ChangeNotifier {
  List<QuestionModel> _questions;
  Map<int, dynamic> _answers = {};
  int currentIndex = 0;
  final FirestoreService _firestoreService = FirestoreService();

  Future loadQuestionsList() async {
    // setBusy(true);
    var postResults = await _firestoreService.getQuestionsOnceOff();
    //setBusy(false);
    if (postResults is List<QuestionModel>) {
      _questions = postResults;
      notifyListeners();
    } else {
      print('failed');
    }
  }

//returning a copy of the list
  List<QuestionModel> get questions => [..._questions];

  void onChanged() {
    notifyListeners();
  }

  Map<int, dynamic> get answers {
    return _answers;
  }

  void clearSelection() {
    _answers.clear();
    currentIndex = 0;
    notifyListeners();
  }

  void nextIndex() {
    currentIndex += 1;
    notifyListeners();
  }

  void lastIndex() {
    currentIndex -= 1;
    notifyListeners();
  }
}
