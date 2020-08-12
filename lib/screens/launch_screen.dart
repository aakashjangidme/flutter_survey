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
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.all(8),
    child: Center(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Image.asset(
                'assets/images/welcome.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to the Survey App !',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 20),
            Text(
              'This app can be intigrated as a module to another app!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(height: 20),
            RoundButon(
                title: "Continue",
                onPressed: () {
                  authScreen(context);
                }),
          ],
        ),
      ),
    ),
  );
}

void authScreen(context) {
  Navigator.pushNamed(context, '/auth');
}
