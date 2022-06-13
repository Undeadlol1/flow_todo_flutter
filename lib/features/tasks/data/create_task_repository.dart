import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

class CreateTaskRepository {
  final FirebaseFirestore firestore;
  const CreateTaskRepository({required this.firestore});

  Future<void> call(Task task) async {
    // TODO test
    await firestore.collection('tasks').doc(task.id).set(task.toJson());
  }
}
