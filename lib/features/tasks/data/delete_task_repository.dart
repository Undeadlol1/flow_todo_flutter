import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

class DeleteTaskRepository {
  final FirebaseFirestore firestore;
  const DeleteTaskRepository({required this.firestore});

  Future<void> call(Task task) async {
    return firestore.collection('tasks').doc(task.id).delete();
  }
}
