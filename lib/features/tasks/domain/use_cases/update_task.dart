import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateTask {
  final UpdateTaskRepository updateTaskRepository;
  const UpdateTask({required this.updateTaskRepository});

  Future<void> call(Task updatedTask) async {
    return updateTaskRepository(
      updatedTask.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch),
    );
  }
}
