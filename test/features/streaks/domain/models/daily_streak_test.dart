import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities/fixtures/daily_streak_fixture.dart';

void main() {
  final today = DateTime.now();
  final yesterday = today.subtract(const Duration(days: 1, hours: 1));
  final twoDaysAgo = today.subtract(const Duration(days: 2));
  final threeDaysAgo = today.subtract(const Duration(days: 3));
  final tenDaysAgo = today.subtract(const Duration(days: 10));
  group('GIVEN DailyStreak', () {
    group('GIVEN .shouldStreakIncrement', () {
      test('WHEN streak strted yesterday THEN returns true', () {
        final result = dailyStreakFixture
            .copyWith(
              perDay: 3,
              startsAt: yesterday,
              updatedAt: null,
            )
            .shouldStreakIncrement(
              tasksDoneToday: 3,
            );

        expect(result, true);
      });

      test('WHEN streak was already incremented today THEN returns false', () {
        final result = dailyStreakFixture
            .copyWith(
              perDay: 3,
              startsAt: twoDaysAgo,
              updatedAt: today.millisecondsSinceEpoch,
            )
            .shouldStreakIncrement(tasksDoneToday: 5);

        expect(result, false);
      });

      test(
        'WHEN streak started yesterday '
        'AND was not updated today  '
        'THEN returns true',
        () {
          final shouldStreakIncrement = dailyStreakFixture
              .copyWith(
                perDay: 3,
                startsAt: yesterday,
                updatedAt: null,
              )
              .shouldStreakIncrement(tasksDoneToday: 5);

          expect(shouldStreakIncrement, true);
        },
      );

      test(
        'WHEN streak started two days ago '
        'AND was updated yesterday '
        'THEN returns true',
        () {
          final shouldStreakIncrement = dailyStreakFixture
              .copyWith(
                perDay: 3,
                startsAt: twoDaysAgo,
                updatedAt: yesterday.millisecondsSinceEpoch,
              )
              .shouldStreakIncrement(tasksDoneToday: 5);

          expect(shouldStreakIncrement, true);
        },
      );
    });

    group(
      'WHEN .isInterrupted called',
      () {
        test(
          'WHEN streak started yesterday '
          'AND streak was never updated '
          'THEN returns false',
          () {
            final isInterrupted = dailyStreakFixture
                .copyWith(
                  updatedAt: null,
                  startsAt: yesterday,
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
          startsAt: startsAt,
          updatedAt: updatedAt.millisecondsSinceEpoch,
        )
        .isInterrupted();

    expect(result, isInterrupted);
  };
}
