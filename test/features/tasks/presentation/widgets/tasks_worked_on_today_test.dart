import 'package:flow_todo_flutter_2022/features/streaks/domain/services/streak_days_in_a_row_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_worked_on_today.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';

class _MockProfileCubit extends Mock implements ProfileCubit {}

class _MockTasksDoneTodayCubit extends Mock implements TasksWorkedOnTodayCubit {
}

final _MockProfileCubit _mockProfileCubit = _MockProfileCubit();
final _MockTasksDoneTodayCubit _mockTasksDoneTodayCubit =
    _MockTasksDoneTodayCubit();

void main() {
  group('GIVEN TasksWorkedOnToday', () {
    setUpAll(() {
      GetIt.I.registerSingleton<StreakDaysInARowCalculator>(
        const StreakDaysInARowCalculator(),
      );
      _stubProfileState(ProfileLoaded(profile: profileFixture));
    });

    group('WHEN pumped', () {
      testWidgets(
        'THEN displays how many tasks are done today',
        (tester) async {
          _stubTasksDoneTodayState(
            TasksWorkedOnTodayState.loaded([taskFixture, taskFixture]),
          );

          await tester.pumpWithDependencies(const TasksWorkedOnToday());

          expect(find.textContaining('Wins today: '), findsOneWidget);
          expect(find.textContaining('2'), findsOneWidget);
        },
      );

      testWidgets(
        'THEN displays progress indicator',
        (tester) async {
          _stubTasksDoneTodayState(TasksWorkedOnTodayState.loaded([]));

          await tester.pumpWithDependencies(const TasksWorkedOnToday());

          expect(find.byType(LinearProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'THEN how many tasks are required per day',
        (tester) async {
          _stubProfileState(ProfileLoaded(profile: profileFixture));
          _stubTasksDoneTodayState(TasksWorkedOnTodayState.loaded([]));

          await tester.pumpWithDependencies(const TasksWorkedOnToday());

          expect(
            find.textContaining(' / ${profileFixture.dailyStreak.perDay}'),
            findsOneWidget,
          );
          expect(find.text(0.toString()), findsWidgets);
        },
      );
    });
  });
}

void _stubProfileState(ProfileState state) {
  when(() => _mockProfileCubit.close()).thenAnswer((_) async {});
  when(() => _mockProfileCubit.state).thenAnswer((_) => state);
  when(() => _mockProfileCubit.stream).thenAnswer((_) => Stream.value(state));
}

void _stubTasksDoneTodayState(TasksWorkedOnTodayState state) {
  when(() => _mockTasksDoneTodayCubit.close()).thenAnswer((_) async {});
  when(() => _mockTasksDoneTodayCubit.state).thenAnswer((_) => state);
  when(() => _mockTasksDoneTodayCubit.stream)
      .thenAnswer((_) => Stream.value(state));
}

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies(Widget child) async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(
            create: (context) => _mockProfileCubit,
          ),
          BlocProvider<TasksWorkedOnTodayCubit>(
            create: (context) => _mockTasksDoneTodayCubit,
          ),
        ],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: child,
        ),
      ),
    );

    await pumpAndSettle();
  }
}
