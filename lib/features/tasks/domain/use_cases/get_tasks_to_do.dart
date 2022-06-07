import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do.dart' as repository;
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:get_it/get_it.dart';

class GetTasksToDo {
  const GetTasksToDo();
  Future<void> call({required String userId}) async {
    final tasksCubit = GetIt.I<TasksCubit>();

    final tasks = await GetIt.I<repository.GetTasksToDo>().call(userId: userId);
    tasksCubit.update(tasks);
  }
}
