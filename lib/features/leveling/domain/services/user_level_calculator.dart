import 'dart:developer';

import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_reach_a_level_calculator.dart';

class UserLevelCalculator {
  final ExperienceToReachALevelCalculator experienceToReachALevelCalculator;

  const UserLevelCalculator({required this.experienceToReachALevelCalculator});

  int call(int userExperience) {
    log('userExperience: ${userExperience}');
    int pointsCalcuated = 0;
    int functionCalledCount = 0;
    while (pointsCalcuated <= userExperience) {
      pointsCalcuated += experienceToReachALevelCalculator(functionCalledCount);
      log('pointsCalculated: ${pointsCalcuated.toString()}');
      log('functionCalledCount: ${functionCalledCount}');
      functionCalledCount++;
    }
    return functionCalledCount - 1;
  }
}
