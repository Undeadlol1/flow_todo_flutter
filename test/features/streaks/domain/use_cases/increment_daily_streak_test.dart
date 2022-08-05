import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/use_cases/increment_daily_streak_action.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_profile_cubit.dart';
import '../../../../test_utilities/mocks/mock_tasks_worked_on_today_cubit.dart';
import '../../../../test_utilities/mocks/mock_upsert_profile_repository.dart';

final _today = DateTime.now();
final _yesterday = DateTime.now().subtract(const Duration(days: 1));

class _FakeGetTodaysDate extends Fake implements GetTodaysDate {
  @override
  DateTime call() => _today;
}

final _mockProfileCubit = MockProfileCubit();
final _fakeGetTodaysDate = _FakeGetTodaysDate();
final _mockTasksDoneTodayCubit = MockTasksWorkedOnTodayCubit();
final _mockUpdateProfileRepository = MockUpsertProfileRepository();

void main() {
  setUp(() {
    reset(_mockTasksDoneTodayCubit);
    reset(_mockUpdateProfileRepository);

    when(() => _mockTasksDoneTodayCubit.update(any())).thenReturn(null);
    when(() => _mockTasksDoneTodayCubit.state)
        .thenReturn(TasksWorkedOnTodayState.loaded([]));
    when(() => _mockProfileCubit.state)
        .thenReturn(ProfileLoaded(profile: profileFixture));
  });

  group('GIVEN IncrementDailyStreak', () {
    setUpAll(() => registerFallbackValue(profileFixture));

    test('WHEN streak is not achieved ' 'THEN does nothing', () async {
      _mockTypicalCalls(profile: profileFixture, tasksDoneToday: []);

      await _getService()();

      verifyNever(
        () => _mockUpdateProfileRepository(captureAny()),
      );
    });

    group('WHEN daily streak is achieved', () {
      test(
        'AND streak has not been updated today THEN updates daily streak',
        () async {
          _mockStatesAndRepos(tasksDoneToday: 3, startsAt: _yesterday);

          await _getService()();

          final profileUpdate = verify(
            () => _mockUpdateProfileRepository(captureAny()),
          );
          final updatedStreak =
              (profileUpdate.captured.first as Profile).dailyStreak;
          profileUpdate.called(1);
          expect(
            updatedStreak.startsAt,
            equals(_yesterday),
            reason: 'Reason: start date must not change',
          );
          expect(updatedStreak.updatedAt, equals(_today));
        },
      );

      test(
        'AND streak has been updated today THEN does not update daily streak',
        () async {
          _mockStatesAndRepos(
            tasksDoneToday: 3,
            startsAt: _yesterday,
            updatedAt: DateTime.now(),
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
  DateTime? updatedAt,
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

IncrementDailyStreakAction _getService() {
  return IncrementDailyStreakAction(
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
    TasksWorkedOnTodayState.loaded(tasksDoneToday),
  );
}
