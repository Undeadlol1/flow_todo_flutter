import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/what_do_you_feel_about_the_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';

void main() {
  group('GIVEN TaskPage', () {
    testWidgets(
      "SHOULD have PageLayoutAndDependencies",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(PageLayoutAndDependencies), findsOneWidget);
      },
    );

    testWidgets(
      'SHOULD display task title',
      _pumpAndRunCallback(
        () => expect(find.text(taskFixture.title), findsOneWidget),
      ),
    );

    testWidgets(
      "SHOULD diplay task decisions",
      _pumpAndRunCallback(() {
        expect(find.byType(WhatDoYouFeelAboutTheTask), findsOneWidget);
      }),
    );
  });
}

Future<void> Function(WidgetTester tester) _pumpAndRunCallback(
  Function callback,
) {
  return (WidgetTester tester) async {
    await _pumpWidget(tester);

    callback();
  };
}

Future<void> _pumpWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: TaskPage(
        task: taskFixture,
      ),
    ),
  );
}
