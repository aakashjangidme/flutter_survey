import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:flutter_survey/models/question_model.dart';

class FirestoreService {
  // final CollectionReference _usersCollectionReference =
  //     Firestore.instance.collection('users');
  final CollectionReference _collectionReference =
      Firestore.instance.collection('questions');

  // final StreamController<List<Post>> _postsController =
  //     StreamController<List<Post>>.broadcast();

  Future getQuestionsOnceOff() async {
    try {
      var postDocumentSnapshot = await _collectionReference.getDocuments();
      if (postDocumentSnapshot.documents.isNotEmpty) {
        print('getting data ');
        return postDocumentSnapshot.documents
            .map((snapshot) => QuestionModel.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.questionText != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
