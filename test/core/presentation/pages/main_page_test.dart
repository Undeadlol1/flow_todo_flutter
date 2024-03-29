import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/domain/use_cases/get_remote_config.dart';
import 'package:flow_todo_flutter_2022/features/analytics/data/traces/navigation_to_filter_page_trace.dart';
import 'package:flow_todo_flutter_2022/core/presentation/pages/main_page.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/sign_in_with_google.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/widgets/google_sign_in_button.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/services/streak_days_in_a_row_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/task_reward_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filter_by_tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/selected_tasks.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_list.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/player_progress_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fakes/fake_user_level_calculator.dart';
import '../../../test_utilities/fixtures/task_fixture.dart';
import '../../../test_utilities/mocks/mock_firebase_remote_config.dart';
import '../../../test_utilities/mocks/mock_hydrated_storage.dart';
import '../../../test_utilities/mocks/mock_level_progress_percentage_calculator.dart';
import '../../../test_utilities/mocks/mock_remote_config_cubit.dart';
import '../../../test_utilities/mocks/mock_filter_by_tags_cubit.dart';
import '../../../test_utilities/mocks/mock_task_reward_calculator.dart';
import '../../../test_utilities/mocks/setupers/setup_filtered_tasks_cubit_mock.dart';

class _MockGetRemoteConfig extends Mock implements GetRemoteConfig {}

class _MockSignInWithGoogle extends Mock implements SignInWithGoogle {}

class _MockNavigateToFilterPageTrace extends Mock
    implements NavigationToFilterPageTrace {}

late ProfileCubit _profileCubit;
late AuthentificationCubit _authCubit;
final _tagsCubit = MockFilterByTagsCubit();
final _remoteConfigCubit = MockRemoteConfigCubit();
final _mockLevelProgressPercentageCalculator =
    MockLevelProgressPercentageCalculator();

void main() {
  group('GIVEN MainPage', () {
    setUpAll(() {
      registerFallbackValue(0);

      _setupTaskRewardCalculatorMock();

      _setupTagsCubitMock();

      _setupRemoteConfigMock();

      _setupRemoteConfigCubit();

      when(() => _mockLevelProgressPercentageCalculator.call(any()))
          .thenReturn(0);

      mockHydratedStorage(() {
        GetIt.I.registerSingleton(FilteredTasksCubit());
      });
      GetIt.I.registerSingleton<GetRemoteConfig>(_MockGetRemoteConfig());
      GetIt.I.registerSingleton<SignInWithGoogle>(_MockSignInWithGoogle());
      GetIt.I.registerSingleton<NavigationToFilterPageTrace>(
        _MockNavigateToFilterPageTrace(),
      );
      GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
      GetIt.I.registerSingleton<StreakDaysInARowCalculator>(
        const StreakDaysInARowCalculator(),
      );
      GetIt.I.registerSingleton<LevelProgressPercentageCalculator>(
        _mockLevelProgressPercentageCalculator,
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

void _setupRemoteConfigMock() {
  final mockFirebaseRemoteConfig = MockFirebaseRemoteConfig();
  when(() => mockFirebaseRemoteConfig.getBool(any())).thenReturn(false);
  GetIt.I.registerSingleton<FirebaseRemoteConfig>(mockFirebaseRemoteConfig);
}

void _setupTagsCubitMock() {
  whenListen(
    _tagsCubit,
    Stream.value(FilterByTagsState({})),
    initialState: FilterByTagsState({}),
  );
  when(() => _tagsCubit.close()).thenAnswer((_) async {});
}

// TODO remove this?
void _setupRemoteConfigCubit() {
  final remoteConfigState = RemoteConfigState.defaults();
  whenListen(
    _remoteConfigCubit,
    Stream.value(remoteConfigState),
    initialState: remoteConfigState,
  );
  when(() => _remoteConfigCubit.close()).thenAnswer((_) async {});
}

void _setupTaskRewardCalculatorMock() {
  registerFallbackValue(taskFixture);

  final mockTaskRewardCalculator = MockTaskRewardCalculator();
  when(() => mockTaskRewardCalculator.taskCompletion(any())).thenReturn(50);

  GetIt.I.registerSingleton<TaskRewardCalculator>(mockTaskRewardCalculator);
}

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies() async {
    await mockHydratedStorage(() async {
      return await pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => _authCubit),
            BlocProvider(create: (_) => TasksToDoCubit()),
            BlocProvider(create: (_) => _profileCubit),
            BlocProvider<FilterByTagsCubit>(create: (_) => _tagsCubit),
            BlocProvider<RemoteConfigCubit>(create: (_) => _remoteConfigCubit),
            BlocProvider<FilteredTasksCubit>(
              create: (_) => setupFileredTasksCubitMock(),
            ),
            BlocProvider(create: (_) => TasksWorkedOnTodayCubit()),
          ],
          child: const MaterialApp(
            home: MainPage(),
          ),
        ),
      );
    });
  }
}
