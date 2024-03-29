import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/foundation.dart';

class GetTasksToDoRepository {
  final FirebaseFirestore firestore;
  const GetTasksToDoRepository({required this.firestore});

  Future<List<Task>> call({required String userId}) async {
    try {
      final tasksSnapshot = await firestore
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .where('isDone', isEqualTo: false)
          .where(
            'dueAt',
            isLessThanOrEqualTo: DateTime.now().millisecondsSinceEpoch,
          )
          .limit(250)
          .get();

      final listOfJsons = tasksSnapshot.docs.map((e) => e.data()).toList();

      return await compute(_parseListOfJsons, listOfJsons);
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}

List<Task> _parseListOfJsons(List<Map<String, dynamic>> docs) {
  return docs.map(Task.fromJson).toList();
}
