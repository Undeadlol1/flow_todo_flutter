import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'tasks_done_today_state.dart';
part 'tasks_done_today_cubit.freezed.dart';

@singleton
class TasksDoneTodayCubit extends Cubit<TasksDoneTodayState>
    with ReplayCubitMixin {
  TasksDoneTodayCubit() : super(TasksDoneTodayState.loading());

  void update(List<Task> tasks) {
    emit(TasksDoneTodayState.loaded(tasks));
  }
}
