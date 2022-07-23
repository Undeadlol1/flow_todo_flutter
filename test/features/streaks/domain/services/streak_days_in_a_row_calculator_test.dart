import 'package:flow_todo_flutter_2022/features/streaks/domain/services/streak_days_in_a_row_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final today = DateTime.now();
  final yesterday = today.subtract(const Duration(days: 1, hours: 1));

  group('GIVEN StreakDaysInARowCalculator', () {
    test('WHEN updatedAt is null THEN returns 0', () {
      expect(
        const StreakDaysInARowCalculator()(
          updatedAt: null,
          startsAt: yesterday,
        ),
        0,
      );
    });

    test('WHEN is called THEN detects days in a row properly', () {
      expect(
        const StreakDaysInARowCalculator()(
          updatedAt: today.millisecondsSinceEpoch,
          startsAt: yesterday,
        ),
        2,
      );
    });
  });
}
