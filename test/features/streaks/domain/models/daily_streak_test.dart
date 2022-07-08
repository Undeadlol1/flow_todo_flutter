import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities/fixtures/daily_streak_fixture.dart';

void main() {
  final today = DateTime.now();
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
  final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));

  group('GIVEN DailyStreak', () {
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
          () {
            final isInterrupted = dailyStreakFixture
                .copyWith(
                  startsAt: yesterday.millisecondsSinceEpoch,
                  updatedAt: today.millisecondsSinceEpoch,
                )
                .isInterrupted();

            expect(isInterrupted, false);
          },
        );

        test('WHEN started and updated yesterday ' 'THEN returns false', () {
          final isInterrupted = dailyStreakFixture
              .copyWith(
                startsAt: yesterday.millisecondsSinceEpoch,
                updatedAt: yesterday.millisecondsSinceEpoch,
              )
              .isInterrupted();

          expect(isInterrupted, false);
        });

        test(
          'WHEN started multiple days ago and was not updated yesterday '
          'THEN returns true',
          () {
            final tenDaysAgo =
                DateTime.now().subtract(const Duration(days: 10));
            final isInterrupted = dailyStreakFixture
                .copyWith(
                  startsAt: tenDaysAgo.millisecondsSinceEpoch,
                  updatedAt: twoDaysAgo.millisecondsSinceEpoch,
                )
                .isInterrupted();

            expect(isInterrupted, true);
          },
        );

        test(
          'WHEN started 3 days ago and was updated two days ago '
          'THEN returns true',
          () {
            final isInterrupted = dailyStreakFixture
                .copyWith(
                  startsAt: threeDaysAgo.millisecondsSinceEpoch,
                  updatedAt: twoDaysAgo.millisecondsSinceEpoch,
                )
                .isInterrupted();

            expect(isInterrupted, true);
          },
        );
      },
    );
  });
}

void _verifyStreakInterrupted({
  required DateTime startsAt,
  required DateTime updatedAt,
  required bool isInterrupted,
}) {
  final result = dailyStreakFixture
      .copyWith(
        startsAt: startsAt.millisecondsSinceEpoch,
        updatedAt: updatedAt.millisecondsSinceEpoch,
      )
      .isInterrupted();

  expect(result, isInterrupted);
}
