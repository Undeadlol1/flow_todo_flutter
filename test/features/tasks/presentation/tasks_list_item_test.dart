import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

class _MockGoToTaskpage extends Mock implements GoToTaskPage {}

void main() {
  final mockGoToTaskpage = _MockGoToTaskpage();

  setUpAll(() {
    when(() => mockGoToTaskpage()).thenAnswer((_) async {});

    GetIt.I.registerFactory<GoToTaskPage>(() => mockGoToTaskpage);
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

        verify(() => mockGoToTaskpage.call()).called(1);
      },
    );
  });
}

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies(Widget child) {
    // ignore: unnecessary_this
    return this.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: child,
      ),
    );
  }
}
