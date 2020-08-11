import 'package:flutter/material.dart';
import 'package:flutter_survey/constants/constants.dart';
import 'package:flutter_survey/screens/home_screen.dart';
import 'package:flutter_survey/screens/launch_screen.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:flutter_survey/screens/results_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuestionState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Counter App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          buttonTheme: ButtonThemeData(
            buttonColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => LaunchScreen(),
          '/home': (context) => HomeScreen(),
          '/result': (context) => ResultScreen(),
          '/login': (context) => LaunchScreen(),
        },
      ),
    );
  }
}
