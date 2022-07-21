import 'package:flow_todo_flutter_2022/features/goals/data/update_goal_repository.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/models/goal.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MakeStepForwardOnAGoal {
  final GoalsCubit goalsCubit;
  final UpdateGoalRepository updateGoalRepo;
  const MakeStepForwardOnAGoal({
    required this.goalsCubit,
    required this.updateGoalRepo,
  });

  Future<void> call(Goal goal) async {
    final updatedGoal = goal.copyWith(
      steps: goal.steps + 1,
      points: goal.points + 10,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    goalsCubit.updateGoal(updatedGoal);
    return updateGoalRepo(updatedGoal);
  }
}
