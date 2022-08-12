import 'package:injectable/injectable.dart';
import 'package:memoize/memoize.dart';

import '../entities/user_level.dart';
import 'experience_to_reach_next_level_calculator.dart';

@injectable
class UserLevelCalculator {
  final ExperienceToReachNextLevelCalculator experienceToReachALevelCalculator;

  UserLevelCalculator({required this.experienceToReachALevelCalculator});

  UserLevel call(int userExperience) {
    return _memoizedUserLevel(userExperience);
  }

  late final _memoizedUserLevel = memo1(_getUserLevel);

  UserLevel _getUserLevel(int userExperience) {
    int functionCalledCount = 0;
    int totalExpToNextLevel = 0;
    int totalExpForCurrentLevel = 0;

    while (totalExpToNextLevel <= userExperience) {
      if (functionCalledCount == 0) {
        totalExpForCurrentLevel;
      }
      // TODO what if user level is only 0 or 1?
      totalExpForCurrentLevel +=
          experienceToReachALevelCalculator(functionCalledCount - 1);
      totalExpToNextLevel +=
          experienceToReachALevelCalculator(functionCalledCount);
      functionCalledCount++;
    }

    return UserLevel(
      // TODO rename to "level";
      value: functionCalledCount - 1,
      totalExperienceToNextLevel: totalExpToNextLevel,
      totalExperienceForCurrentLevel: totalExpForCurrentLevel,
    );
  }
}
