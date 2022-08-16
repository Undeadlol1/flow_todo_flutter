import 'package:injectable/injectable.dart';

import 'experience_to_reach_next_level_calculator.dart';
import 'user_level_calculator.dart';

@singleton
class LevelProgressPercentageCalculator {
  final UserLevelCalculator userLevelCalculator;
  final ExperienceToReachNextLevelCalculator experienceToReachALevelCalculator;
  const LevelProgressPercentageCalculator({
    required this.userLevelCalculator,
    required this.experienceToReachALevelCalculator,
  });

  double call(int experience) {
    final level = userLevelCalculator(experience);

    if (level.totalExperienceForCurrentLevel <= 0) return 0;

    final userProgressInExpNumbers =
        experience - level.totalExperienceForCurrentLevel;

    final differenceBetweenLevels =
        level.totalExperienceToNextLevel - level.totalExperienceForCurrentLevel;

    final progressPercent =
        (userProgressInExpNumbers * 100) / differenceBetweenLevels;

    return progressPercent;
  }
}
