import 'package:flutter/material.dart';
import 'package:flutter_survey/constants/constants.dart';
import 'package:flutter_survey/widgets/round_button.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    var s = ModalRoute.of(context).settings.arguments;
    print(s);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Thank you,\nYour response has been added succesfully',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Icon(
              Icons.check_circle_outline,
              size: 50,
              color: kPrimaryColor,
            ),
            SizedBox(height: 20),
            RoundButon(
              title: 'Go back',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            SizedBox(height: 20),
            RoundButon(
              title: 'Sign Out',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        )),
      ),
    );
  }
}
