import 'dart:math';

import 'package:flow_todo_flutter_2022/features/leveling/domain/entities/leveling_config.dart';

class ExperienceToNextLevelCalculator {
  final LevelingConfig levelingConfig;
  const ExperienceToNextLevelCalculator({required this.levelingConfig});

  int call(int level) {
    // levelingConfig.experienceToLevelMapper[0];
    const baseXP = 30;
    const exponent = 1.1;
    return (baseXP * pow(level, exponent)).toInt();
  }
}
