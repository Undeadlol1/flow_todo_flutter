import '../entities/leveling_config.dart';

class ExperienceToReachNextLevelCalculator {
  final LevelingConfig levelingConfig;
  const ExperienceToReachNextLevelCalculator({required this.levelingConfig});

  int call(int desiredLevel) {
    if (levelingConfig.experienceToLevelMapper.containsKey(desiredLevel)) {
      return levelingConfig.experienceToLevelMapper[desiredLevel]!;
    } else {
      return levelingConfig.fallbackExperienceToLevelCalculator(desiredLevel);
    }
  }
}
