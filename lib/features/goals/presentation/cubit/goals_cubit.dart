import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../domain/models/goal.dart';

part 'goals_state.dart';
part 'goals_cubit.freezed.dart';

@singleton
class GoalsCubit extends Cubit<GoalsState> with ReplayCubitMixin {
  GoalsCubit() : super(GoalsState.loading());

  void update(List<Goal> goals) {
    emit(GoalsState.loaded(goals));
  }
}
