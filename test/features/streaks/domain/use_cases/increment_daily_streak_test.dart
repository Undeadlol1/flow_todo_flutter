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
          _mockStatesAndRepos(tasksDoneToday: 3, startsAt: yesterday);

          await _getService()();

          final profileUpdate = verify(
            () => _mockUpdateProfileRepository(captureAny()),
          );
          final updatedStreak =
              (profileUpdate.captured.first as Profile).dailyStreak;
          profileUpdate.called(1);
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
          _mockStatesAndRepos(
            tasksDoneToday: 3,
            startsAt: yesterday,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
          );

          await _getService()();

          verifyNever(
            () => _mockUpdateProfileRepository(captureAny()),
          );
        },
      );
    });
  });
}

void _mockStatesAndRepos({
  int? updatedAt,
  required DateTime startsAt,
  required int tasksDoneToday,
}) {
  final tasksList = List.generate(tasksDoneToday, (index) => taskFixture);
  final profile = profileFixture.copyWith.dailyStreak(
    startsAt: startsAt,
    updatedAt: updatedAt,
    perDay: tasksDoneToday,
  );

  assert(tasksList.length == tasksDoneToday);
  assert(profile.dailyStreak.perDay == tasksDoneToday);

  _mockTypicalCalls(tasksDoneToday: tasksList, profile: profile);
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
