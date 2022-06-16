import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_next_level_calculator.dart';

class ExperienceToReachALevelCalculator {
  final ExperienceToNextLevelCalculator experienceToNextLevelCalculator;
  const ExperienceToReachALevelCalculator({
    required this.experienceToNextLevelCalculator,
  });

  int call(int desiredLevel) {
    int level = 0;
    int expCalculated = 0;

    while (level <= desiredLevel) {
      expCalculated += experienceToNextLevelCalculator(level);
      level++;
    }

    return expCalculated - experienceToNextLevelCalculator(level - 1);
  }
}
