import 'package:bloc/bloc.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_done_today_state.dart';
part 'tasks_done_today_cubit.freezed.dart';

class TasksDoneTodayCubit extends Cubit<TasksDoneTodayState> {
  TasksDoneTodayCubit() : super(TasksDoneTodayState.loading());

  void update(List<Task> tasks) {
    emit(TasksDoneTodayState.loaded(tasks));
  }
}
