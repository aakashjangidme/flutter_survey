import 'package:flutter/material.dart';
import 'package:flutter_survey/constants/constants.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:provider/provider.dart';



class OutOfCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<BaseProvider>(
        builder: (context, value, child) => Text(
          '${value.currentIndex + 1} out of ${value.questions.length}',
          style: TextStyle(
              fontSize: 20, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}