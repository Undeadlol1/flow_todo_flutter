import 'dart:async';
import 'package:flow_todo_flutter_2022/features/goals/data/get_goals_repository.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/use_case_exception_handler.dart';

@singleton
class GetGoals {
  final GoalsCubit goalsCubit;
  final GetGoalsRepository getGoalsRepo;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  const GetGoals({
    required this.goalsCubit,
    required this.getGoalsRepo,
    required this.useCaseExceptionHandler,
  });

  Future<void> call({required String userId}) {
    return getGoalsRepo(userId: userId)
        .then(goalsCubit.update)
        .onError(_handleException);
  }

  void _handleException(error, stack) {
    useCaseExceptionHandler.call(error!, stack);
  }
}
