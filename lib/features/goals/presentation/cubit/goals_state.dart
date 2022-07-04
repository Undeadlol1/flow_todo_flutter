part of 'goals_cubit.dart';

@freezed
class GoalsState with _$GoalsState {
  GoalsState._();
  final List<Goal> goals = [];

  factory GoalsState.loading() = _loading;
  factory GoalsState.loaded(List<Goal> goals) = _loaded;
}
