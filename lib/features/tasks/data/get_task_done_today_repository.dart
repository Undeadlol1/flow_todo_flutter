import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetTasksDoneTodayRepository {
  final FirebaseFirestore firestore;
  const GetTasksDoneTodayRepository({required this.firestore});

  Future<List<Task>> call({required String userId}) async {
    final yesterday =
        DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch;

    final tasksSnapshot = await firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('updatedAt', isGreaterThanOrEqualTo: yesterday)
        .limit(250)
        .get();

    return compute(_parseListOfJsons, tasksSnapshot);
  }
}

List<Task> _parseListOfJsons(QuerySnapshot<Map<String, dynamic>> snapshots) {
  final listOfJsons = snapshots.docs.map((e) => e.data()).toList();
  return listOfJsons.map(Task.fromJson).toList();
}
