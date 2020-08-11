import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_survey/models/service.dart';
import 'package:flutter_survey/providers/provider.dart';

class AuthProvider extends QuestionState {
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirestoreService _firestoreService = FirestoreService();



}