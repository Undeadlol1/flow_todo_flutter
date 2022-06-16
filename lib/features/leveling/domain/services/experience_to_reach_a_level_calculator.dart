import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_next_level_calculator.dart';

import '../entities/leveling_config.dart';

class ExperienceToReachALevelCalculator {
  final LevelingConfig levelingConfig;
  const ExperienceToReachALevelCalculator({required this.levelingConfig});

  int call(int desiredLevel) {
    if (levelingConfig.experienceToLevelMapper.containsKey(desiredLevel)) {
      // TODO try this:
      // levelingConfig.experienceToLevelMapper.putIfAbsent(key, () => null)
      return levelingConfig.experienceToLevelMapper[desiredLevel]!;
    }
    return 0;
    // int level = 0;
    // int expCalculated = 0;

    // while (level <= desiredLevel) {
    //   expCalculated += experienceToNextLevelCalculator(level);
    //   level++;
    // }

    // return expCalculated - experienceToNextLevelCalculator(level - 1);
  }
}
