import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/foundation.dart';

class GetTasksToDoRepository {
  final FirebaseFirestore firestore;
  const GetTasksToDoRepository({required this.firestore});

  Future<List<Task>> call({required String userId}) async {
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

    return compute(_parseListOfJsons, tasksSnapshot);
  }
}

List<Task> _parseListOfJsons(QuerySnapshot<Map<String, dynamic>> snapshots) {
  final listOfJsons = snapshots.docs.map((e) => e.data()).toList();
  return listOfJsons.map(Task.fromJson).toList();
}
