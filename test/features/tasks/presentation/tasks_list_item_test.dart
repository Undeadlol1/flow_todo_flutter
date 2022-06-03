import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN TasksListItem', () {
    testWidgets(
      'THEN displays task title',
      (tester) async {
        await tester.pumpWithDependencies(
          TasksListItem(task: _mockedTask),
        );

        expect(find.text(_mockedTask.title), findsOneWidget);
      },
    );
  });
}

final _mockedTask = Task(
  id: 'id',
  dueAt: 23,
  isDone: false,
  createdAt: 23,
  title: 'title',
  userId: 'userId',
);

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
