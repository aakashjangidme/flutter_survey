import 'package:flutter/material.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:provider/provider.dart';

class QuestionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionState>(
      builder: (context, ques, child) => Container(
        padding: EdgeInsets.only(top: 32),
        child: Text(
          ques.questions[ques.currentIndex].questionText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
