import 'package:flutter/material.dart';
import 'package:flutter_survey/constants/constants.dart';
import 'package:flutter_survey/providers/auth_provider.dart';
import 'package:flutter_survey/providers/provider.dart';
import 'package:flutter_survey/widgets/round_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum FormType { login, register }

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
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                        labelText: 'Email'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'Password'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                //login/signup button here
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: Consumer<AuthProvider>(
                    builder: (context, auth, child) =>
                        auth.status == Status.Authenticating
                            ? CircularProgressIndicator()
                            : RoundButon(
                                onPressed: () async {
                                  //
                                  if (_formKey.currentState.validate()) {
                                    _formType == FormType.login
                                        ? _signInWithEmailAndPassword()
                                        : _register();
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                                title: _formType == FormType.login
                                    ? 'Login'
                                    : 'Register',
                              ),
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

  //with Provider

  void _signInWithEmailAndPassword() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.signInEmailPass(
      _emailController.text,
      _passwordController.text,
    );

    if (auth.getCurrentUser != null) {
      auth.authSuccess();
      auth.getUserEmail(_emailController.text);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      auth.authFailed();
    }
  }

//register
  void _register() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.createUserEmailPass(
      _emailController.text,
      _passwordController.text,
    );

    if (auth.getCurrentUser != null) {
      auth.authSuccess();
      auth.getUserEmail(_emailController.text);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      auth.authFailed();
    }
  }
}

_buildFooter() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'The Survey App',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        '\n© 2020 Survey App',
        textAlign: TextAlign.center,
      ),
    ],
  );
}
