import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTaskRepository {
  final FirebaseFirestore firestore;
  const CreateTaskRepository({required this.firestore});

  Future<void> call(Task task) async {
    await firestore.collection('tasks').doc(task.id).set(
      {
        'id': task.id,
        // 'note': updatedTask.note,
        // 'name': updatedTask.title,
        // 'updatedAt': updatedTask.updatedAt,
        // 'repetitionLevel': updatedTask.repetitionLevel,
      },
    );
  }
}
