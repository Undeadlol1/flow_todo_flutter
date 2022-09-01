import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/task.dart';

part 'selected_tasks_state.dart';
part 'selected_tasks_cubit.freezed.dart';

@singleton
@Deprecated('Cubit is obsolete and needs to be deleted')
class SelectedTasksCubit extends Cubit<SelectedTasksState> {
  SelectedTasksCubit() : super(const SelectedTasksState([]));

  void update(List<Task> tasks) => emit(SelectedTasksState(tasks));
}
