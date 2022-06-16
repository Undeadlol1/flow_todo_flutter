import '../entities/leveling_config.dart';

class ExperienceToReachNextLevelCalculator {
  final LevelingConfig levelingConfig;
  const ExperienceToReachNextLevelCalculator({required this.levelingConfig});

  int call(int desiredLevel) {
    if (levelingConfig.experienceToLevelMapper.containsKey(desiredLevel)) {
      // TODO try this:
      // levelingConfig.experienceToLevelMapper.putIfAbsent(key, () => null)
      return levelingConfig.experienceToLevelMapper[desiredLevel]!;
    } else {
      return levelingConfig.fallbackExperienceToLevelCalculator(desiredLevel);
    }
  }
}
