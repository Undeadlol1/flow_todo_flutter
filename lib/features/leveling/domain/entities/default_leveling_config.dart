import 'dart:math';

import 'package:flow_todo_flutter_2022/features/leveling/domain/entities/leveling_config.dart';

class DefaultLevelingConfig implements LevelingConfig {
  @override
  Map<int, int> get experienceToLevelMapper => {
        1: 100,
        2: 150,
        3: 220,
      };

  @override
  int Function(int level) get fallbackExperienceToLevelCalculator {
    return (level) {
      const baseXP = 30;
      const exponent = 1;
      return (baseXP * pow(level, exponent)).toInt();
    };
  }
}
