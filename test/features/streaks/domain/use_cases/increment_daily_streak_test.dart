import 'package:flow_todo_flutter_2022/features/streaks/domain/use_cases/increment_daily_streak.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fakes/fake_get_todays_date.dart';
import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_profile_cubit.dart';
import '../../../../test_utilities/mocks/mock_tasks_done_today_cubit.dart';
import '../../../../test_utilities/mocks/mock_update_profile_repository.dart';

final _mockProfileCubit = MockProfileCubit();
final _fakeGetTodaysDate = FakeGetTodaysDate();
final _mockTasksDoneTodayCubit = MockTasksDoneTodayCubit();
final _mockUpdateProfileRepository = MockUpdateProfileRepository();

void main() {
  final yesterday = DateTime.now().subtract(const Duration(days: 1));

  setUp(() {
    reset(_mockTasksDoneTodayCubit);
    reset(_mockUpdateProfileRepository);

    when(() => _mockTasksDoneTodayCubit.update(any())).thenReturn(null);
    when(() => _mockTasksDoneTodayCubit.state)
        .thenReturn(TasksDoneTodayState.loaded([]));
    when(() => _mockProfileCubit.state)
        .thenReturn(ProfileLoaded(profile: profileFixture));
  });

  group('GIVEN IncrementDailyStreak', () {
    group('WHEN daily streak is achieved', () {
      setUpAll(() => registerFallbackValue(profileFixture));

      test(
        'AND streak has not been updated today THEN updates daily streak',
        () async {
          final tasksDoneToday = [taskFixture, taskFixture, taskFixture];
          final profileWithAchievedStreak = profileFixture.copyWith.dailyStreak(
            perDay: tasksDoneToday.length,
            startsAt: yesterday,
          );
          _mockTypicalCalls(
            tasksDoneToday: tasksDoneToday,
            profile: profileWithAchievedStreak,
          );

          final shouldDailyStreakIncrement = profileWithAchievedStreak
              .dailyStreak
              .shouldStreakIncrement(tasksDoneToday: tasksDoneToday.length);

          await _getService()();

          final profileUpdate = verify(
            () => _mockUpdateProfileRepository(captureAny()),
          );
          final updatedStreak =
              (profileUpdate.captured.first as Profile).dailyStreak;
          profileUpdate.called(1);
          expect(shouldDailyStreakIncrement, isTrue);
          expect(
            updatedStreak.startsAt,
            equals(yesterday),
            reason: 'Reason: start date must not change',
          );
          expect(
            updatedStreak.updatedAt,
            equals(_fakeGetTodaysDate.returnedValue.millisecondsSinceEpoch),
          );
        },
      );

      test(
        'AND streak has been updated today THEN does not update daily streak',
        () async {
          _mockSomething(3, yesterday);

          await _getService()();

          verifyNever(
            () => _mockUpdateProfileRepository(captureAny()),
          );
        },
      );
    });
  });
}

// TODO rename
void _mockSomething(int length, DateTime yesterday) {
  final tasksDoneToday = List.generate(length, (index) => taskFixture);
  expect(tasksDoneToday, hasLength(length));

  final profileWithAchievedStreak = profileFixture.copyWith.dailyStreak(
    perDay: length,
    startsAt: yesterday,
    updatedAt: DateTime.now().millisecondsSinceEpoch,
  );
  _mockTypicalCalls(
    tasksDoneToday: tasksDoneToday,
    profile: profileWithAchievedStreak,
  );
}

IncrementDailyStreak _getService() {
  return IncrementDailyStreak(
    profileCubit: _mockProfileCubit,
    getTodaysDate: _fakeGetTodaysDate,
    updateProfile: _mockUpdateProfileRepository,
    tasksDoneTodayCubit: _mockTasksDoneTodayCubit,
  );
}

void _mockTypicalCalls({
  required Profile profile,
  required List<Task> tasksDoneToday,
}) {
  when(() => _mockUpdateProfileRepository(any())).thenAnswer(Future.value);
  when(() => _mockProfileCubit.state)
      .thenReturn(ProfileLoaded(profile: profile));
  when((() => _mockTasksDoneTodayCubit.state)).thenReturn(
    TasksDoneTodayState.loaded(tasksDoneToday),
  );
}
