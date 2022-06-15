import 'dart:math';

class PointsToNextLevelCalculator {
  const PointsToNextLevelCalculator();

  int call(int level) {
    const baseXP = 30;
    const exponent = 1.1;
    return (baseXP * pow(level, exponent)).toInt();
  }
}
