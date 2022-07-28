import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/serializable_document.dart';

class CommonFirestoreCrudRepository<modelType extends SerializableDocument> {
  const CommonFirestoreCrudRepository({required this.firestore});

  final FirebaseFirestore firestore;

  Future<void> create(modelType model) async {
    await firestore.collection('tasks').doc(model.id).set(model.toJson());
  }
}


// final some =  CommonFirestoreCrudRepository<Task>().create(Task());
