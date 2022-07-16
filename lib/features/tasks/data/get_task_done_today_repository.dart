import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetTasksDoneTodayRepository {
  final FirebaseFirestore firestore;
  const GetTasksDoneTodayRepository({required this.firestore});

  Future<List<Task>> call({required String userId}) async {
    final tasksSnapshot = await firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where(
          'updatedAt',
          isGreaterThanOrEqualTo: _getDateOfYesterdaysMidnight(),
        )
        .limit(250)
        .get();

    final listOfJsons = tasksSnapshot.docs.map((e) => e.data()).toList();

    return compute(_parseListOfJsons, listOfJsons);
  }
}

List<Task> _parseListOfJsons(List<Map<String, dynamic>> docs) {
  return docs.map(Task.fromJson).toList();
}

int _getDateOfYesterdaysMidnight() {
  final now = DateTime.now();
  final yesterdayMidnight = DateTime(now.year, now.month, now.day);
  return yesterdayMidnight.millisecondsSinceEpoch;
}
