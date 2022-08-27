import 'package:flow_todo_flutter_2022/features/analytics/data/traces/navigation_to_filter_page_trace.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/sign_in_with_google.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/widgets/google_sign_in_button.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/core/presentation/pages/main_page.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/services/streak_days_in_a_row_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/task_reward_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/selected_tasks.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_worked_on_today.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_list.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/player_progress_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fakes/fake_user_level_calculator.dart';
import '../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../test_utilities/fixtures/task_fixture.dart';
import '../../../test_utilities/mocks/mock_hydrated_storage.dart';
import '../../../test_utilities/mocks/mock_level_progress_percentage_calculator.dart';
import '../../../test_utilities/mocks/mock_task_reward_calculator.dart';

class _MockSignInWithGoogle extends Mock implements SignInWithGoogle {}

class _MockNavigateToFilterPageTrace extends Mock
    implements NavigationToFilterPageTrace {}

late ProfileCubit _profileCubit;
late AuthentificationCubit _authCubit;

void main() {
  group('GIVEN MainPage', () {
    setUpAll(() {
      _setupTaskRewardCalculatorMock();

      mockHydratedStorage(() {
        GetIt.I.registerSingleton(FilteredTasksCubit());
      });
      GetIt.I.registerSingleton<SignInWithGoogle>(_MockSignInWithGoogle());
      GetIt.I.registerSingleton<NavigationToFilterPageTrace>(
          _MockNavigateToFilterPageTrace());
      GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
      GetIt.I.registerSingleton<StreakDaysInARowCalculator>(
        const StreakDaysInARowCalculator(),
      );
      GetIt.I.registerSingleton<LevelProgressPercentageCalculator>(
        MockLevelProgressPercentageCalculator(),
      );
    });

    setUp(() {
      mockHydratedStorage(() {
        _profileCubit = ProfileCubit();
        _authCubit = AuthentificationCubit();
      });
    });

    tearDownAll(GetIt.I.reset);

    testWidgets(
      "SHOULD have PageLayoutAndDependencies",
      (WidgetTester tester) async {
        await tester.pumpWithDependencies();

        expect(find.byType(PageLayout), findsOneWidget);
      },
    );

    testWidgets(
      "SHOULD display TasksList",
      (WidgetTester tester) async {
        await tester.pumpWithDependencies();

        expect(find.byType(TasksList), findsOneWidget);
      },
    );

    testWidgets(
      "SHOULD display SelectedTasks",
      (WidgetTester tester) async {
        await tester.pumpWithDependencies();

        expect(find.byType(SelectedTasks), findsOneWidget);
      },
    );

    group("WHEN user is logged in THEN", () {
      setUp(() => _profileCubit.setProfile(profileFixture));

      testWidgets(
        "displays TasksDoneToday",
        (WidgetTester tester) async {
          await tester.pumpWithDependencies();

          expect(find.byType(TasksWorkedOnToday), findsOneWidget);
        },
      );
    });

    testWidgets(
      "WHEN user is not logged in "
      "THEN does not display PlayerProgressSummary",
      (WidgetTester tester) async {
        _profileCubit.setProfileNotFoundOrUnloaded();

        await tester.pumpWithDependencies();

        expect(find.byType(PlayerProgressSummary), findsNothing);
      },
    );

    testWidgets(
      "WHEN user is not logged in "
      "THEN displays google sign in button",
      (WidgetTester tester) async {
        _authCubit.setNotAuthenticated();

        await tester.pumpWithDependencies();

        expect(find.byType(GoogleSignInButton), findsOneWidget);
      },
    );
  });
}

void _setupTaskRewardCalculatorMock() {
  registerFallbackValue(taskFixture);

  final mockTaskRewardCalculator = MockTaskRewardCalculator();
  when(() => mockTaskRewardCalculator(any())).thenReturn(50);

  GetIt.I.registerSingleton<TaskRewardCalculator>(mockTaskRewardCalculator);
}

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies() async {
    await mockHydratedStorage(() async {
      return await pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _authCubit),
            BlocProvider(create: (context) => TasksCubit()),
            BlocProvider(create: (context) => _profileCubit),
            BlocProvider(create: (context) => TasksWorkedOnTodayCubit()),
          ],
          child: const MaterialApp(
            home: MainPage(),
          ),
        ),
      );
    });
  }
}
