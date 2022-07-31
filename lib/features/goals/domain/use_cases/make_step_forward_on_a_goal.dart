import 'package:flow_todo_flutter_2022/features/goals/data/update_goal_repository.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/models/goal.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/data/upsert_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_debounce/easy_debounce.dart';

@lazySingleton
class MakeStepForwardOnAGoal {
  final GoalsCubit goalsCubit;
  final ProfileCubit profileCubit;
  final UpdateGoalRepository updateGoalRepo;
  final UpsertProfileRepository updateProfileRepository;
  MakeStepForwardOnAGoal({
    required this.goalsCubit,
    required this.profileCubit,
    required this.updateGoalRepo,
    required this.updateProfileRepository,
  });

  static const _pointsToAdd = 10;

  Future<void> call(Goal goal) async {
    final updatedGoal = _getUpdatedGoal(goal);

    goalsCubit.updateGoal(updatedGoal);
    profileCubit.addPoints(_pointsToAdd);

    return _debounceRepositoryCall(updatedGoal);
  }

  void _debounceRepositoryCall(Goal updatedGoal) {
    EasyDebounce.debounce(
      'goals-update-debouncle-id',
      const Duration(milliseconds: 2500),
      () {
        updateGoalRepo(updatedGoal);
        updateProfileRepository(profileCubit.state.profile!);
      },
    );
  }

  Goal _getUpdatedGoal(Goal goal) {
    return goal.copyWith(
      steps: goal.steps + 1,
      points: goal.points + _pointsToAdd,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
