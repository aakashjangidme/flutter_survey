import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:flutter_survey/models/question_model.dart';

class FirestoreService {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('questions');

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
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
