import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _success = false;
  String _userEmail = '';
  Status _status = Status.Uninitialized;
  Status get status => _status;
  get success => _success;
  get userEmail => _userEmail;

  authSuccess() {
    _success = true;
    _status = Status.Authenticated;

    notifyListeners();
  }

  void authFailed() {
    _success = false;
    _status = Status.Unauthenticated;

    notifyListeners();
  }

  void getUserEmail(String newEmail) {
    _userEmail = newEmail;
    notifyListeners();
  }

  Future signInEmailPass(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return e.message;
    }
  }

  Future createUserEmailPass(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      notifyListeners();
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return e.message;
    }
  }

  Future get getCurrentUser async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return user.email;
    } catch (e) {
      _status = Status.Uninitialized;
      notifyListeners();
      return e.message;
    }
  }

  Future<bool> isUserSignedIn() async {
    final FirebaseUser currentuser = await _auth.currentUser();

    return currentuser != null;
  }

  Future<void> signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
