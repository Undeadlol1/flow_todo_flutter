import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task_history.dart';
import 'package:flutter/material.dart';

class GetTasksToDoRepository {
  final FirebaseFirestore firestore;
  const GetTasksToDoRepository({required this.firestore});

  Future<List<Task>> call({required String userId}) async {
    final tasks = await firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('isDone', isEqualTo: false)
        .where('dueAt',
            isLessThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
        .limit(100)
        .get();

    // List<String> names = [];

    // tasks.docs.forEach((element) {
    //   if (element.data()['id'] == null) {
    //     names.add(element.data()['name']);
    //   }
    // });

    // names.forEach(debugPrint);

    // return [];

    return tasks.docs.map((e) {
      // debugPrint(e.get('name'));
      // debugPrint('dueAt.toString ${e.get('dueAt').toString()}');
      // debugPrint('dueAt typeof ${e.get('dueAt').runtimeType}');
      // debugPrint(e.get('dueAt').toString());
      // debugPrint(e.get('name'));
      // debugPrint(e.get('id'));
      // debugPrint('createdAt.toString ${e.get('createdAt').toString()}');
      // debugPrint('createdAt typeof ${e.get('createdAt').runtimeType}');
      // debugPrint(e.get('createdAt').toString());

      return Task.fromJson(e.data());
      //   final data = e.data();
      //   final List<String> tags = data['tags'] == null
      //       ? []
      //       : List.from(data['tags']).map((e) => e.toString()).toList();
      //   final List<TaskHistory> taskActionsHistory = data['history'] == null
      //       ? []
      //       : List.from(data['history']).map((e) {
      //           return TaskHistory(
      //             userId: e['userId'],
      //             taskId: e['taskId'],
      //             comment: e['comment'],
      //             createdAt: e['createdAt'],
      //             actionType: e['actionType'],
      //           );
      //         }).toList();

      //   // TODO are all fields properly set?
      //   return TaskEntity(
      //     tags: tags,
      //     history: taskActionsHistory,
      //     title: data['name'],
      //     dueAt: data['dueAt'],
      //     isDone: data['isDone'],
      //     id: data['id'].toString(),
      //     userId: data['userId'].toString(),
      //     createdAt: data['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
      //   );
    }).toList();
  }
}
