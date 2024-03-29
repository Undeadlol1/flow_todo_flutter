import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/delete_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:injectable/injectable.dart';

import '../../../common/services/snackbar_service.dart';
import 'go_to_task_page.dart';

@singleton
class RejectTask {
  final TasksToDoCubit tasksCubit;
  final GoToMainPage goToMainPage;
  final GoToTaskPage goToTaskPage;
  final SnackbarService snackbarService;
  final AddPointsToViewer addPointsToUser;
  final FirebaseAnalytics firebaseAnalytics;
  final DeleteTaskRepository deleteTaskRepository;
  RejectTask({
    required this.tasksCubit,
    required this.goToMainPage,
    required this.goToTaskPage,
    required this.snackbarService,
    required this.addPointsToUser,
    required this.firebaseAnalytics,
    required this.deleteTaskRepository,
  });

  static const _encouragingText = "Don't be afraid to get rid of unimportant "
      "tasks. You have been awarded with experience";

  Future<void> call(Task task) async {
    try {
      goToMainPage();

      tasksCubit.removeTask(task);
      snackbarService.displaySnackbar(text: _encouragingText);

      addPointsToUser(10);
      deleteTaskRepository(task);

      return firebaseAnalytics.logEvent(name: 'rejected_task');
    } catch (error) {
      snackbarService.displaySnackbar(text: error.toString());

      tasksCubit.undo();

      return goToTaskPage(task: task);
    }
  }
}
