import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/models/service.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:flutter_survey/widgets/question_counter.dart';
import 'package:flutter_survey/widgets/answer_list.dart';
import 'package:flutter_survey/widgets/question_text.dart';
import 'package:flutter_survey/widgets/round_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// do it with the provider now
final FirebaseAuth _auth = FirebaseAuth.instance;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    Provider.of<QuestionState>(context, listen: false).clearSelection();
    Provider.of<QuestionState>(context, listen: false).loadQuestionsList();
  }

  @override
  Widget build(BuildContext context) {
    var _email = ModalRoute.of(context).settings.arguments;
    print('Successfully signed in as ' + '$_email');
//Todo: Set Method to show Welcome Email.
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Survey App'),
        actions: <Widget>[
          //Todo : Change icons fontAwesome lib
          IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                _signOut();
              }),
        ],
      ),
      body: homeScreenBody(context),
    );
  }

  void _signOut() async {
    await _auth.signOut();
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
          Consumer<QuestionState>(
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

          Divider(),

          SizedBox(
            height: 16
          ),

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

          SizedBox(height: 20),

          Consumer<QuestionState>(
            builder: (context, value, child) => RoundButon(
              title: value.currentIndex == (value.questions.length - 1)
                  ? "Submit"
                  : "Next",
              onPressed: () {
                onPressedSubmitButton(context);
              },
            ),
          ),
          // RoundButon(title: 'press me', onPressed: ()=>_onPressed(),)
        ],
      ),
    ),
  );
}

//
void onPressedBackButton(context) {
  Provider.of<QuestionState>(context, listen: false).lastIndex();
}

//
void onPressedSubmitButton(context) {
  QuestionState data = Provider.of<QuestionState>(context, listen: false);

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
