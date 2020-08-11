import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/constants/constants.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:flutter_survey/widgets/round_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum FormType { login, register }

final FirebaseAuth _auth = FirebaseAuth.instance;

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
        elevation: 0,
      ),
      body: _EmailPasswordForm(),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FormType _formType = FormType.login;

  bool _success;
  String _userEmail;
  //

  void registerWidget() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void loginWidget() {
    _formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    Provider.of<BaseProvider>(context, listen: false).loadQuestionsList();

    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        _formType == FormType.login
                            ? 'Sign In to Continue'
                            : 'Please, Register to Continue',
                        style: GoogleFonts.raleway(
                          fontSize: 28,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Enter your email and password below to continue to the The Survey App!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: RoundButon(
                    onPressed: () async {
                      //
                      if (_formKey.currentState.validate()) {
                        _formType == FormType.login
                            ? _signInWithEmailAndPassword()
                            : _register();
                        //
                      }
                      FocusScope.of(context).unfocus();
                    },
                    title: _formType == FormType.login ? 'Login' : 'Register',
                  ),
                ),

                Text('Not Registered?'),

                FlatButton(
                  hoverColor: kPrimaryColor,
                  onPressed: () {
                    _formType == FormType.login
                        ? registerWidget()
                        : loginWidget();
                  },
                  child:
                      Text(_formType == FormType.login ? 'Sign Up' : 'Log In'),
                ),
                SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooter(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

//signIn
  void _signInWithEmailAndPassword() async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      print(user);
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
      Navigator.pushReplacementNamed(context, '/home', arguments: _userEmail);
    } else {
      _success = false;
    }
  }

//register
  void _register() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Hello $_userEmail"),
                content: Text("Press continue to go to survey !"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home',
                          arguments: _userEmail);
                    },
                  ),
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/');
                    },
                  ),
                ],
              ));
    } else {
      _success = false;
    }
  }
}

_buildFooter() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'The Survey App',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text('\n© 2020 Survey App'),
    ],
  );
}
