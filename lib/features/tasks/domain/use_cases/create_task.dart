import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateTask {
  final TasksToDoCubit tasksCubit;
  final ProfileCubit profileCubit;
  final GetTodaysDate getTodaysDate;
  final AddPointsToViewer addPointsToUser;
  final FirebaseAnalytics firebaseAnalytics;
  final UniqueIdGenerator uniqueIdGenerator;
  final CreateTaskRepository createTaskRepository;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  CreateTask({
    required this.tasksCubit,
    required this.profileCubit,
    required this.getTodaysDate,
    required this.addPointsToUser,
    required this.firebaseAnalytics,
    required this.uniqueIdGenerator,
    required this.createTaskRepository,
    required this.useCaseExceptionHandler,
  });

  Future<void> call({
    required String title,
    required String userId,
    required List<String> tags,
    bool isSelected = false,
  }) async {
    try {
      final profileState = profileCubit.state;
      final taskToCreate = Task(
        note: '',
        tags: tags,
        history: [],
        isDone: false,
        userId: userId,
        title: title.trim(),
        isSelected: isSelected,
        id: uniqueIdGenerator(),
        dueAt: getTodaysDate(),
        createdAt: getTodaysDate(),
      );

      if (profileState is ProfileLoaded) {
        addPointsToUser(10);
      }
      tasksCubit
          .updateList([...tasksCubit.state.tasks]..insert(0, taskToCreate));

      await createTaskRepository(taskToCreate);

      return firebaseAnalytics.logEvent(name: 'create_task');
    } catch (error, stack) {
      useCaseExceptionHandler(error, stack);
    }
  }
}
