import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetTasksToDo {
  final FirebaseFirestore firestore;
  const GetTasksToDo({required this.firestore});

  Future<List<Task>> call({required String userId}) async {
    final tasks = await firestore
        .collection('tasks')
        .where(
          'userId',
          isEqualTo: userId,
        )
        .where('isDone', isEqualTo: false)
        .where('dueAt', isLessThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
        .limit(100)
        .get();

    if (tasks.size == 0) {
      return [];
    } else {
      return tasks.docs.map((e) {
        final data = e.data();
        return Task(
          id: data['id'].toString(),
          title: data['title'].toString(),
          userId: data['userId'].toString(),
          isDone: data['isDone'],
          dueAt: data['dueAt'],
          createdAt: data['createdAt'],
        );
      }).toList();
    }
  }
}
