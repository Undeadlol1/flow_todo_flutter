import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_next_level_calculator.dart';

class UserLevelCalculator {
  final ExperienceToNextLevelCalculator expToNextLevelCalculator;

  const UserLevelCalculator({required this.expToNextLevelCalculator});

  int call(int userExperience) {
    int pointsCalcuated = 0;
    int functionCalledCount = 0;
    while (pointsCalcuated <= userExperience) {
      pointsCalcuated += expToNextLevelCalculator(functionCalledCount);
      functionCalledCount++;
    }
    return functionCalledCount - 1;
  }
}
