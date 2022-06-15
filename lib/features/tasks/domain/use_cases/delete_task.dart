import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/delete_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';

class DeleteTask {
  final TasksCubit tasksCubit;
  final GoToMainPage goToMainPage;
  final AddPointsToViewer addPointsToUser;
  final DeleteTaskRepository deleteTaskRepository;
  DeleteTask({
    required this.tasksCubit,
    required this.goToMainPage,
    required this.addPointsToUser,
    required this.deleteTaskRepository,
  });

  Future<void> call(Task task) async {
    goToMainPage();

    tasksCubit.state.tasks.remove(task);
    tasksCubit.update(tasksCubit.state.tasks);

    deleteTaskRepository(task);

    return addPointsToUser(10);
  }
}
