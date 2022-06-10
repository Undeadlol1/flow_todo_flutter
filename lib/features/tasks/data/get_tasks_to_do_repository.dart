import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

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

    return tasks.docs.map((e) => Task.fromJson(e.data())).toList();
  }
}
