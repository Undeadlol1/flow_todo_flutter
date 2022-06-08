import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetTasksToDoRepository {
  final FirebaseFirestore firestore;
  const GetTasksToDoRepository({required this.firestore});

  Future<List<Task>> call({required String userId}) async {
    final tasks = await firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('isDone', isEqualTo: false)
        .where('dueAt', isLessThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
        .limit(100)
        .get();

    return tasks.docs.map((e) {
      final data = e.data();
      return Task(
        // TODO are all fields properly set?
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
