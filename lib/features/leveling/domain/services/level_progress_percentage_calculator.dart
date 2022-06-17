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

    final userProgressInExpNumbers = experience - level.totalExperienceForCurrentLevel;

    final differenceBetweenLevels =
        level.totalExperienceToNextLevel - level.totalExperienceForCurrentLevel;

    final progressPercent = (userProgressInExpNumbers * 100) / differenceBetweenLevels;

    return progressPercent;
  }
}