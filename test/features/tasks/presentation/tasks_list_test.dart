import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN TasksList', () {
    group('WHEN pumped ', () {
      // testWidgets(
      //   'THEN displays how many tasks are done today',
      //   (tester) async {
      //     await tester.pumpWithDependencies(const TasksList());

      //     expect(find.text('Wins today: 0'), findsOneWidget);
      //   },
      // );
    });
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
