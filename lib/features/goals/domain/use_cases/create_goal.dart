import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/goals/data/create_goal_repository.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/models/goal.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateGoal {
  final GoalsCubit goalsCubit;
  final ProfileCubit profileCubit;
  final GetTodaysDate getTodaysDate;
  final AddPointsToViewer addPointsToUser;
  final CreateGoalRepository createGoalRepo;
  final UniqueIdGenerator uniqueIdGenerator;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  CreateGoal({
    required this.goalsCubit,
    required this.profileCubit,
    required this.getTodaysDate,
    required this.createGoalRepo,
    required this.addPointsToUser,
    required this.uniqueIdGenerator,
    required this.useCaseExceptionHandler,
  });

  Future<void> call({required String title, required String userId}) async {
    try {
      final goalToCreate = Goal(
        steps: 0,
        points: 0,
        userId: userId,
        title: title.trim(),
        id: uniqueIdGenerator(),
        createdAt: getTodaysDate().millisecondsSinceEpoch,
      );

      if (profileCubit.state is ProfileLoaded) {
        addPointsToUser(10);
      }
      goalsCubit.update([goalToCreate, ...goalsCubit.state.goals]);

      return createGoalRepo(goalToCreate);
    } on Exception catch (error) {
      goalsCubit.undo();
      useCaseExceptionHandler.handleException(error);
      rethrow;
    }
  }
}
