import 'dart:developer';

import 'package:flow_todo_flutter_2022/features/goals/data/update_goal_repository.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/models/goal.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_debounce/easy_debounce.dart';

@lazySingleton
class MakeStepForwardOnAGoal {
  final GoalsCubit goalsCubit;
  final UpdateGoalRepository updateGoalRepo;
  MakeStepForwardOnAGoal({
    required this.goalsCubit,
    required this.updateGoalRepo,
  });

  int _timesUseCaseCalled = 0;

  Future<void> call(Goal goal) async {
    log('goal: ${goal.toString()}');
    final updatedGoal = goal.copyWith(
      steps: 1 + goal.steps,
      points: 10 + goal.points,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    goalsCubit.updateGoal(updatedGoal);

    return _debounceRepositoryCall(updatedGoal);
  }

  void _debounceRepositoryCall(Goal goal) {
    _timesUseCaseCalled++;
    EasyDebounce.debounce(
      'goals-update-debouncle-id',
      const Duration(milliseconds: 1500),
      () => callRepository(goal),
    );
  }

  Future<void> callRepository(Goal updatedGoal) {
    log('Actual  function call');
    log('amount called $_timesUseCaseCalled');
    _timesUseCaseCalled = 0;
    return updateGoalRepo(updatedGoal);
  }
}
