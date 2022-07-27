import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/sign_in_with_google.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/widgets/google_sign_in_button.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/core/presentation/pages/main_page.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/services/streak_days_in_a_row_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/filter_active_tasks.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_done_today.dart';
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
import '../../../test_utilities/mocks/mock_level_progress_percentage_calculator.dart';

class _MockSignInWithGoogle extends Mock implements SignInWithGoogle {}

final _tasksCuibit = TasksCubit();
var _profileCubit = ProfileCubit();
var _authCubit = AuthentificationCubit();

void main() {
  group('GIVEN MainPage', () {
    setUp(() {
      _profileCubit = ProfileCubit();
      _authCubit = AuthentificationCubit();
    });

    setUpAll(() {
      GetIt.I.registerSingleton(_authCubit);
      GetIt.I.registerSingleton(_tasksCuibit);
      GetIt.I.registerSingleton<SignInWithGoogle>(_MockSignInWithGoogle());
      GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
      GetIt.I.registerSingleton<StreakDaysInARowCalculator>(
        const StreakDaysInARowCalculator(),
      );
      GetIt.I.registerSingleton<LevelProgressPercentageCalculator>(
        MockLevelProgressPercentageCalculator(),
      );
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
      "SHOULD display TasksList",
      (WidgetTester tester) async {
        await tester.pumpWithDependencies();

        expect(find.byType(FilterActiveTasks), findsOneWidget);
      },
    );

    testWidgets(
      "WHEN user is logged in "
      "THEN displays TasksDoneToday",
      (WidgetTester tester) async {
        _profileCubit.setProfile(profileFixture);

        await tester.pumpWithDependencies();

        expect(find.byType(TasksDoneToday), findsOneWidget);
      },
    );

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

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies() async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _authCubit),
          BlocProvider(create: (context) => _tasksCuibit),
          BlocProvider(create: (context) => _profileCubit),
          BlocProvider(create: (context) => TasksDoneTodayCubit()),
        ],
        child: const MaterialApp(
          home: MainPage(),
        ),
      ),
    );
  }
}
