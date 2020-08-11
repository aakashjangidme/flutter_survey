import 'package:flutter/material.dart';
import 'package:flutter_survey/constants/constants.dart';
import 'package:flutter_survey/widgets/round_button.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
        elevation: 0,
      ),
      body: launchScreen(context),
    );
  }
}

Widget launchScreen(context) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Welcome',
                ),
                TextSpan(text: ' to'),
                TextSpan(
                  text: '\nThe App',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              ]),
        ),
        // SizedBox(
        //   height: 50.0,
        // ),
        RoundButon(
            title: "Continue",
            onPressed: () {
              authScreen(context);
            }),
      ],
    ),
  );
}

void authScreen(context) {
  Navigator.pushReplacementNamed(context, '/home');
}
