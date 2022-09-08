import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'tasks_worked_on_today_state.dart';
part 'tasks_worked_on_today_cubit.g.dart';
part 'tasks_worked_on_today_cubit.freezed.dart';

@singleton
class TasksWorkedOnTodayCubit extends HydratedCubit<TasksWorkedOnTodayState>
    with ReplayCubitMixin {
  TasksWorkedOnTodayCubit() : super(TasksWorkedOnTodayState.loading());

  void update(List<Task> tasks) {
    emit(TasksWorkedOnTodayState.loaded(tasks));
  }

  @override
  Map<String, dynamic> toJson(state) => state.toJson();
  @override
  TasksWorkedOnTodayState fromJson(Map<String, dynamic> json) =>
      TasksWorkedOnTodayState.fromJson(json);
}
