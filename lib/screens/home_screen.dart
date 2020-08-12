import 'package:flutter/material.dart';
import 'package:flutter_survey/providers/auth_provider.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:flutter_survey/widgets/question_counter.dart';
import 'package:flutter_survey/widgets/answer_list.dart';
import 'package:flutter_survey/widgets/question_text.dart';
import 'package:flutter_survey/widgets/round_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    Provider.of<BaseProvider>(context, listen: false).clearSelection();
    // Provider.of<BaseProvider>(context, listen: false).loadQuestionsList();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: true);
    print('Successfully signed in as ' + ' ${user.userEmail} ');
//Todo: Set Method to show Welcome Email.
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Survey App',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          //Todo : Change icons fontAwesome lib
          IconButton(
              icon: const Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                _signOut();
              }),
        ],
      ),
      body: homeScreenBody(context),
    );
  }

  void _signOut() async {
    var auth = Provider.of<AuthProvider>(context, listen: false);

    await auth.signOut();
    Navigator.popAndPushNamed(context, '/');
  }
}

Widget homeScreenBody(context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Consumer<BaseProvider>(
            builder: (context, value, child) => SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //
                  RoundButon(
                    title: 'back',
                    width: 100,
                    onPressed: value.currentIndex == 0
                        ? null
                        : () {
                            onPressedBackButton(context);
                          },
                  ),

                  SizedBox(width: 50),

                  //heading Maybe
                  OutOfCounter(),
                ],
              ),
            ),
          ),

          Divider(
            thickness: 1,
            height: 30,
          ),

          SizedBox(height: 15),

          // Text(
          //   'Hello, ${Provider.of<AuthProvider>(context, listen: false).userEmail}',
          //   style: TextStyle(fontSize: 18),
          // ),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Hello,\n',
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        ' ${Provider.of<AuthProvider>(context, listen: false).userEmail}',
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
          ),

          SizedBox(height: 30),

          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //
                QuestionText(),
                SizedBox(height: 20),
                //
                AnswerList(),
              ],
            ),
          ),

          SizedBox(height: 50),

          Consumer<BaseProvider>(
            builder: (context, value, child) => RoundButon(
              title: value.currentIndex == (value.questions.length - 1)
                  ? "Submit"
                  : "Next",
              onPressed: () {
                onPressedSubmitButton(context);
              },
            ),
          ),
        ],
      ),
    ),
  );
}

//
void onPressedBackButton(context) {
  Provider.of<BaseProvider>(context, listen: false).lastIndex();
}

//
void onPressedSubmitButton(context) {
  BaseProvider data = Provider.of<BaseProvider>(context, listen: false);

  if (data.answers[data.currentIndex] == null) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("You must select an answer to continue."),
    ));
    return;
  }
  if (data.currentIndex < (data.questions.length - 1)) {
    data.nextIndex();
  } else {
    print('End of the Quiz');
    //Passing data to the route '/result'
    Navigator.of(context).pushReplacementNamed('/result', arguments: {
      'questions': data.questions.map((e) => e.questionText),
      'answers': data.answers
    });
  }
}
