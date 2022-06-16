import 'experience_to_reach_a_level_calculator.dart';
import 'user_level_calculator.dart';

class LevelProgressPercentageCalculator {
  final UserLevelCalculator userLevelCalculator;
  final ExperienceToReachALevelCalculator experienceToReachALevelCalculator;
  const LevelProgressPercentageCalculator({
    required this.userLevelCalculator,
    required this.experienceToReachALevelCalculator,
  });

  double call(int experience) {
    final level = userLevelCalculator(experience);
    final experienceToNextLevel = experienceToReachALevelCalculator(level + 1);
    final experienceToCurrentLevel = experienceToReachALevelCalculator(level);

    final differenceBetweenLevels = experienceToNextLevel - experienceToCurrentLevel;
    final userProgressInPoints = experience - experienceToCurrentLevel;
    final progressPercent = (userProgressInPoints * 100) / differenceBetweenLevels;

    return progressPercent;
  }
}
