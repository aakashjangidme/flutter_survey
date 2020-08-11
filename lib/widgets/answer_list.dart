import 'package:flutter/material.dart';
import 'package:flutter_survey/constants/constants.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:provider/provider.dart';

class AnswerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionState data = Provider.of<QuestionState>(context, listen: false);
    return SizedBox(
      height: 250,
      child: Consumer<QuestionState>(
        builder: (context, ques, child) => ListView(
          padding: EdgeInsets.all(8.0),
          children: ques.questions[ques.currentIndex].answerText
              .map((answer) => RadioListTile(
                    groupValue: data.answers[data.currentIndex],
                    title: Text(
                      '$answer',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    value: answer,
                    // selected: true,
                    activeColor: kPrimaryColor,
                    onChanged: (val) {
                      print(val);

                      //calling provider here
                      data.answers[data.currentIndex] = answer;
                      //calling onChanged from my ProviderClass to update the UI when my option gets selected.
                      ques.onChanged();
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
