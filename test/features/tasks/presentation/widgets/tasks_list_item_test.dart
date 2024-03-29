import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/task_reward_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_go_to_task_page.dart';
import '../../../../test_utilities/mocks/mock_stale_task_detector.dart';
import '../../../../test_utilities/mocks/mock_task_reward_calculator.dart';

void main() {
  final mockGoToTaskpage = MockGoToTaskPage();
  final mockStaleTaskDetector = MockStaleTaskDetector();
  final mockTaskRewardCalculator = MockTaskRewardCalculator();

  setUpAll(() {
    registerFallbackValue(taskFixture);

    when(() => mockTaskRewardCalculator.taskCompletion(any())).thenReturn(50);
    when(() => mockStaleTaskDetector.isStale(any())).thenReturn(false);
    when(() => mockGoToTaskpage(task: taskFixture)).thenAnswer((_) async {});

    GetIt.I.registerFactory<GoToTaskPage>(() => mockGoToTaskpage);
    GetIt.I.registerSingleton<StaleTaskDetector>(mockStaleTaskDetector);
    GetIt.I.registerSingleton<TaskRewardCalculator>(mockTaskRewardCalculator);
  });

  group('GIVEN TasksListItem', () {
    testWidgets(
      'THEN displays task title',
      (tester) async {
        await tester.pumpWithDependencies(
          TasksListItem(task: taskFixture),
        );

        expect(find.text(taskFixture.title), findsOneWidget);
      },
    );

    testWidgets(
      'WHEN item is tapped '
      'THEN calls navigation use case',
      (tester) async {
        await tester.pumpWithDependencies(
          TasksListItem(task: taskFixture),
        );
        await tester.tap(find.text(taskFixture.title));

        verify(() => mockGoToTaskpage.call(task: taskFixture)).called(1);
      },
    );
  });
}

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies(Widget child) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }
}
