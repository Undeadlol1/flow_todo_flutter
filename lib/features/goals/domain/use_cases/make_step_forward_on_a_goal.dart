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

  Future<void> call(Goal goal) async {
    final updatedGoal = _getUpdatedGoal(goal);

    goalsCubit.updateGoal(updatedGoal);

    return _debounceRepositoryCall(updatedGoal);
  }

  void _debounceRepositoryCall(Goal updatedGoal) {
    EasyDebounce.debounce(
      'goals-update-debouncle-id',
      const Duration(milliseconds: 2500),
      () => updateGoalRepo(updatedGoal),
    );
  }

  Goal _getUpdatedGoal(Goal goal) {
    return goal.copyWith(
      steps: 1 + goal.steps,
      points: 10 + goal.points,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
