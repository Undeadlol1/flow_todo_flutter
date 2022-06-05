import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/pages/presentation/main_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN MainPage', () {
    testWidgets(
      "SHOULD have PageLayoutAndDependencies",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(PageLayoutAndDependencies), findsOneWidget);
      },
    );

    testWidgets(
      "SHOULD display TasksList",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(TasksList), findsOneWidget);
      },
    );
  });
}

Future<void> _pumpWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: MainPage(),
    ),
  );
}
