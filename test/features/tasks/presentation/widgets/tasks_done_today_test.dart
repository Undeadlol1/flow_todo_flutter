import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_done_today.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';

class _MockProfileCubit extends Mock implements ProfileCubit {}

class _MockTasksDoneTodayCubit extends Mock implements TasksDoneTodayCubit {}

final _MockProfileCubit _mockProfileCubit = _MockProfileCubit();
final _MockTasksDoneTodayCubit _mockTasksDoneTodayCubit =
    _MockTasksDoneTodayCubit();

void main() {
  group('GIVEN TasksDoneToday', () {
    setUpAll(() {
      _stubProfileState(const ProfileLoaded(profile: profileFixture));
    });

    group('WHEN pumped', () {
      testWidgets(
        'THEN displays how many tasks are done today',
        (tester) async {
          _stubTasksDoneTodayState(
            TasksDoneTodayState.loaded([taskFixture, taskFixture]),
          );

          await tester.pumpWithDependencies(const TasksDoneToday());

          expect(find.textContaining('Wins today: 2'), findsOneWidget);
        },
      );

      testWidgets(
        'THEN displays progress indicator',
        (tester) async {
          _stubTasksDoneTodayState(TasksDoneTodayState.loaded([]));

          await tester.pumpWithDependencies(const TasksDoneToday());

          expect(find.byType(LinearProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'THEN how many tasks are required per day',
        (tester) async {
          _stubProfileState(const ProfileLoaded(profile: profileFixture));
          _stubTasksDoneTodayState(TasksDoneTodayState.loaded([]));

          await tester.pumpWithDependencies(const TasksDoneToday());

          expect(
            find.textContaining('0 / ${profileFixture.dailyStreak.perDay}'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'THEN displays daily streak',
        (tester) async {
          await tester.pumpWithDependencies(const TasksDoneToday());

          expect(find.text('Won days in a row: 0'), findsOneWidget);
        },
      );
      // );
    });
  });
}

void _stubProfileState(ProfileState state) {
  when(() => _mockProfileCubit.close()).thenAnswer((_) async {});
  when(() => _mockProfileCubit.state).thenAnswer((_) => state);
  when(() => _mockProfileCubit.stream).thenAnswer((_) => Stream.value(state));
}

void _stubTasksDoneTodayState(TasksDoneTodayState state) {
  when(() => _mockTasksDoneTodayCubit.close()).thenAnswer((_) async {});
  when(() => _mockTasksDoneTodayCubit.state).thenAnswer((_) => state);
  when(() => _mockTasksDoneTodayCubit.stream)
      .thenAnswer((_) => Stream.value(state));
}

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies(Widget child) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(
            create: (context) => _mockProfileCubit,
          ),
          BlocProvider<TasksDoneTodayCubit>(
            create: (context) => _mockTasksDoneTodayCubit,
          ),
        ],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: child,
        ),
      ),
    );
  }
}
