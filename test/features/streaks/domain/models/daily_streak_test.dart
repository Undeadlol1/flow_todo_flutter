import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities/fixtures/daily_streak_fixture.dart';

void main() {
  final today = DateTime.now();
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
  final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
  final tenDaysAgo = DateTime.now().subtract(const Duration(days: 10));
  group('GIVEN DailyStreak', () {
    test('WHEN .daysInARow is called THEN detects days in a row properly', () {
      final daysInARow = dailyStreakFixture
          .copyWith(
            startsAt: yesterday.millisecondsSinceEpoch,
            updatedAt: today.millisecondsSinceEpoch,
          )
          .getDaysInARow();

      expect(daysInARow, 2);
    });

    group(
      'WHEN .isInterrupted called',
      () {
        test(
          'WHEN streak started yesterday and was not updated today '
          'THEN returns false',
          () {
            final isInterrupted = dailyStreakFixture
                .copyWith(
                  updatedAt: null,
                  startsAt: yesterday.millisecondsSinceEpoch,
                )
                .isInterrupted();

            expect(isInterrupted, false);
          },
        );

        test(
          'WHEN streak started yesterday and was updated today '
          'THEN returns false',
          _verifyIsStreakInterrupted(
            updatedAt: today,
            startsAt: yesterday,
            isInterrupted: false,
          ),
        );

        test(
          'WHEN started and updated yesterday ' 'THEN returns false',
          _verifyIsStreakInterrupted(
            isInterrupted: false,
            startsAt: yesterday,
            updatedAt: yesterday,
          ),
        );

        test(
          'WHEN started multiple days ago and was not updated yesterday '
          'THEN returns true',
          _verifyIsStreakInterrupted(
            isInterrupted: true,
            startsAt: tenDaysAgo,
            updatedAt: twoDaysAgo,
          ),
        );

        test(
          'WHEN started 3 days ago and was updated two days ago '
          'THEN returns true',
          _verifyIsStreakInterrupted(
            isInterrupted: true,
            updatedAt: twoDaysAgo,
            startsAt: threeDaysAgo,
          ),
        );
      },
    );
  });
}

_verifyIsStreakInterrupted({
  required DateTime startsAt,
  required DateTime updatedAt,
  required bool isInterrupted,
}) {
  return () {
    final result = dailyStreakFixture
        .copyWith(
          startsAt: startsAt.millisecondsSinceEpoch,
          updatedAt: updatedAt.millisecondsSinceEpoch,
        )
        .isInterrupted();

    expect(result, isInterrupted);
  };
}
