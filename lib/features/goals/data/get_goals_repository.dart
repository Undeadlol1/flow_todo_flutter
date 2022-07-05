import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../domain/models/goal.dart';

// TODO use lazy singleton?
@singleton
class GetGoalsRepository {
  final FirebaseFirestore firestore;
  const GetGoalsRepository({required this.firestore});

  Future<List<Goal>> call({required String userId}) async {
    final tasksSnapshot = await firestore
        .collection('goals')
        .where('userId', isEqualTo: userId)
        .limit(250)
        .get();

    final listOfJsons = tasksSnapshot.docs.map((e) => e.data()).toList();

    return compute(_parseListOfJsons, listOfJsons);
  }
}

List<Goal> _parseListOfJsons(List<Map<String, dynamic>> docs) {
  return docs.map(Goal.fromJson).toList();
}
