import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetTasksToDo {
  final TasksCubit tasksCubit;
  final GetTasksToDoRepository getTasks;
  GetTasksToDo({required this.getTasks, required this.tasksCubit});

  Future<void> call({required String userId}) async {
    tasksCubit.setLoading();

    final tasks = await getTasks(userId: userId);

    tasks.sort(
      (first, second) => first.createdAt.compareTo(second.createdAt),
    );

    tasksCubit.updateList(tasks..shuffle());
  }
}
