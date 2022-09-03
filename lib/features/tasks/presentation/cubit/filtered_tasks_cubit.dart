import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/task.dart';

part 'filtered_tasks_state.dart';
part 'filtered_tasks_cubit.freezed.dart';

@singleton
class FilteredTasksCubit extends Cubit<FilteredTasksState> {
  FilteredTasksCubit() : super(FilteredTasksState([]));

  void update(List<Task> tasks) => emit(FilteredTasksState(tasks));
}
