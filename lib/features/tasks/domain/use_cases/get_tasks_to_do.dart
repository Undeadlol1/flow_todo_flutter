import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:get_it/get_it.dart';

class GetTasksToDo {
  const GetTasksToDo();
  Future<void> call({required String userId}) async {
    final tasksCubit = GetIt.I<TasksCubit>();
    final getTasks = GetIt.I<GetTasksToDoRepository>();

    final tasks = await getTasks(userId: userId);
    // NOTE: sort tasks semi randomly. Meaning tasks are sorted randomly but
    // the same list is going to have the same order each time it is loaded.
    tasks.sort((first, second) => first.id.compareTo(second.id));
    tasksCubit.updateList(tasks.reversed.toList());
  }
}
