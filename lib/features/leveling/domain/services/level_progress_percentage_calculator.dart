import 'dart:developer';

import 'experience_to_reach_next_level_calculator.dart';
import 'user_level_calculator.dart';

class LevelProgressPercentageCalculator {
  final UserLevelCalculator userLevelCalculator;
  final ExperienceToReachNextLevelCalculator experienceToReachALevelCalculator;
  const LevelProgressPercentageCalculator({
    required this.userLevelCalculator,
    required this.experienceToReachALevelCalculator,
  });

  double call(int experience) {
    final level = userLevelCalculator(experience);
    log('level.value: ${level.value.toString()}');
    log('exp: ${experience.toString()}');
    log('level.totalExperienceToNextLevel: ${level.totalExperienceToNextLevel.toString()}');

    final experienceToCurrentLevel = experienceToReachALevelCalculator(level.value);
    final userProgressInExpNumbers = experience - level.totalExperienceForCurrentLevel;

    final differenceBetweenLevels =
        level.totalExperienceToNextLevel - level.totalExperienceForCurrentLevel;
    log('experienceToCurrentLevel: ${experienceToCurrentLevel.toString()}');
    log('differenceBetweenLevels: ${differenceBetweenLevels.toString()}');
    log('userProgressInPoints: ${userProgressInExpNumbers.toString()}');

    final progressPercent = (userProgressInExpNumbers * 100) / differenceBetweenLevels;

    return progressPercent;
  }
}
