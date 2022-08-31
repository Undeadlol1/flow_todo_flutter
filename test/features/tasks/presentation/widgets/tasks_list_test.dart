import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/task_reward_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_list.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_list_item.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_firebase_remote_config.dart';
import '../../../../test_utilities/mocks/mock_hydrated_storage.dart';
import '../../../../test_utilities/mocks/mock_stale_task_detector.dart';
import '../../../../test_utilities/mocks/mock_tags_cubit.dart';
import '../../../../test_utilities/mocks/mock_task_reward_calculator.dart';

final _mockTagsCubit = MockTagsCubit();

void main() {
  setUpAll(() {
    final mockStaleTaskDetector = MockStaleTaskDetector();
    final mockTaskRewardCalculator = MockTaskRewardCalculator();
    final mockFirebaseRemoteConfig = MockFirebaseRemoteConfig();

    registerFallbackValue(taskFixture);

    whenListen(
      _mockTagsCubit,
      Stream.value(TagsState({})),
      initialState: TagsState({}),
    );

    when(() => _mockTagsCubit.close()).thenAnswer((_) async {});
    when(() => mockStaleTaskDetector.isStale(any())).thenReturn(false);
    when(() => mockFirebaseRemoteConfig.getBool(any())).thenReturn(false);
    when(() => mockTaskRewardCalculator.taskCompletion(any())).thenReturn(50);

    GetIt.I.registerFactory(() => FilteredTasksCubit());
    GetIt.I.registerSingleton<StaleTaskDetector>(mockStaleTaskDetector);
    GetIt.I.registerSingleton<TaskRewardCalculator>(mockTaskRewardCalculator);
    GetIt.I.registerSingleton<FirebaseRemoteConfig>(mockFirebaseRemoteConfig);
  });

  tearDownAll(GetIt.I.reset);

  group('GIVEN TasksList', () {
    testWidgets(
      'WHEN there are no tasks '
      'THEN displays nothing',
      (tester) async {
        await mockHydratedStorage(() async {
          final cubit = TasksCubit()..updateList([]);

          await tester.pumpWithDependencies(
            tasksCubit: cubit,
            child: const TasksList(),
          );

          expect(find.byType(TasksListItem), findsNothing);
        });
      },
    );

    group('WHEN there tasks tasks', () {
      testWidgets('THEN displays exact number of TasksListItem',
          (tester) async {
        await mockHydratedStorage(
          () async {
            final cubit = TasksCubit()..updateList([taskFixture, taskFixture]);

            await tester.pumpWithDependencies(
              tasksCubit: cubit,
              child: const TasksList(),
            );

            expect(find.byType(TasksListItem), findsNWidgets(2));
          },
        );
      });
    });
  });
}

extension on WidgetTester {
  Future<void> pumpWithDependencies({
    required Widget child,
    required TasksCubit tasksCubit,
  }) {
    if (GetIt.I.isRegistered<TasksCubit>()) {
      tasksCubit.close();
      GetIt.I.unregister<TasksCubit>();
    }
    GetIt.I.registerSingleton(tasksCubit);

    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => tasksCubit),
              BlocProvider(create: (_) => ProfileCubit()),
              BlocProvider<TagsCubit>(create: (_) => _mockTagsCubit),
            ],
            child: child,
          ),
        ),
      ),
    );
  }
}
