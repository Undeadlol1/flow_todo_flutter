import 'dart:developer';

import '../entities/leveling_config.dart';

class ExperienceToReachALevelCalculator {
  final LevelingConfig levelingConfig;
  const ExperienceToReachALevelCalculator({required this.levelingConfig});

  int call(int desiredLevel) {
    log('desiredLevel: ${desiredLevel}');
    if (levelingConfig.experienceToLevelMapper.containsKey(desiredLevel)) {
      // TODO try this:
      // levelingConfig.experienceToLevelMapper.putIfAbsent(key, () => null)
      return levelingConfig.experienceToLevelMapper[desiredLevel]!;
    } else {
      return levelingConfig.fallbackExperienceToLevelCalculator(desiredLevel);
    }
  }
}
