import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_survey/models/question_model.dart';
import 'package:flutter_survey/providers/provider.dart';



class Auth extends BaseProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInEmailPass(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user.uid.toString();
  }

  Future createUserEmailPass(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    return user != null ? user.uid : null;
  }

  Future<bool> isUserSignedIn() async {
    final FirebaseUser currentuser = await _firebaseAuth.currentUser();

    return currentuser != null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
