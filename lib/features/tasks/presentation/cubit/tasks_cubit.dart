import 'package:bloc/bloc.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
}
