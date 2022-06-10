import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_entity.dart';

class GetTasksToDoRepository {
  final FirebaseFirestore firestore;
  const GetTasksToDoRepository({required this.firestore});

  Future<List<TaskEntity>> call({required String userId}) async {
    final tasks = await firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('isDone', isEqualTo: false)
        .where('dueAt',
            isLessThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
        .limit(100)
        .get();

    return tasks.docs.map((e) {
      final data = e.data();
      final List<String> tags = data['tags'] == null
          ? []
          : List.from(data['tags']).map((e) => e.toString()).toList();
      final List<TaskHistoryEntity> taskActionsHistory = data['history'] == null
          ? []
          : List.from(data['history']).map((e) {
              return TaskHistoryEntity(
                userId: e['userId'],
                taskId: e['taskId'],
                comment: e['comment'],
                createdAt: e['createdAt'],
                actionType: e['actionType'],
              );
            }).toList();

      // TODO are all fields properly set?
      return TaskEntity(
        tags: tags,
        history: taskActionsHistory,
        title: data['name'],
        dueAt: data['dueAt'],
        isDone: data['isDone'],
        id: data['id'].toString(),
        userId: data['userId'].toString(),
        createdAt: data['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
      );
    }).toList();
  }
}
