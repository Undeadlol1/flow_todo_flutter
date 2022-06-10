import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTaskRepository {
  final FirebaseFirestore firestore;
  const UpdateTaskRepository({required this.firestore});

  Future<void> call(TaskEntity updatedTask) async {
    return firestore.collection('tasks').doc(updatedTask.id).update(
      {
        'note': updatedTask.note,
        'name': updatedTask.title,
        'updatedAt': updatedTask.updatedAt,
        'repetitionLevel': updatedTask.repetitionLevel,
      },
    );
  }
}
