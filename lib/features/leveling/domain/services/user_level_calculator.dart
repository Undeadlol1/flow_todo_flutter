import 'package:flow_todo_flutter_2022/features/leveling/domain/services/points_to_next_level_calculator.dart';

class UserLevelCalculator {
  final PointsToNextLevelCalculator pointsToNextLevelCalculator;

  const UserLevelCalculator({required this.pointsToNextLevelCalculator});

  int call(int userPoints) {
    int pointsCalcuated = 0;
    int functionCalledCount = 0;
    while (pointsCalcuated <= userPoints) {
      pointsCalcuated += pointsToNextLevelCalculator(functionCalledCount);
      functionCalledCount++;
    }
    return functionCalledCount - 1;
  }
}
