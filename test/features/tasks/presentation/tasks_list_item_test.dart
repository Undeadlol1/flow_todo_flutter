import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

void main() {
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
