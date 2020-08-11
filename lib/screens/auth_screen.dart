import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/providers/provider.dart';
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
    Provider.of<QuestionState>(context, listen: false).loadQuestionsList();

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: _formType == FormType.login
                  ? const Text('Login with Email and Password')
                  : Text('Register'),
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
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  //
                  if (_formKey.currentState.validate()) {
                    _formType == FormType.login
                        ? _signInWithEmailAndPassword()
                        : _register();
                    //
                  }
                },
                child: Text(_formType == FormType.login ? 'Login' : 'Register'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null
                    ? ''
                    : (_success
                        ? 'Successfully signed in as ' + _userEmail
                        : 'Sign in failed'),
                style: TextStyle(color: Colors.red),
              ),
            ),
            FlatButton(
                onPressed: () {
                  _formType == FormType.login
                      ? registerWidget()
                      : loginWidget();
                },
                child: Text(_formType == FormType.login ? 'Sign Up' : 'Log In'))
          ],
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
