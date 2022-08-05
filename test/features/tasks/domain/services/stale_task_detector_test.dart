import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final today = DateTime.now();
  final detector = StaleTaskDetector();
  final fiveDaysAgo = today.subtract(const Duration(days: 5));

  Task buildtask({
    DateTime? createdAt,
    DateTime? dueAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: 'id',
      tags: [],
      note: '',
      history: [],
      isDone: false,
      title: 'title',
      userId: 'userId',
      updatedAt: updatedAt?.millisecondsSinceEpoch,
      dueAt: dueAt ?? today,
      createdAt: createdAt ?? today,
    );
  }

  group('GIVEN StaleTaskDetector', () {
    test(
      'WHEN task wasn\'t worked on after creation '
      'THEN returns true',
      () {
        expect(
          detector.isTale(buildtask(createdAt: fiveDaysAgo)),
          isTrue,
        );
      },
    );

    test(
      'WHEN task wasn\'t worked on when it is due '
      'THEN returns true',
      () {
        expect(detector.isTale(buildtask(dueAt: fiveDaysAgo)), isTrue);
      },
    );

    test(
      'WHEN task is old but was updated '
      'THEN returns false',
      () {
        expect(
          detector.isTale(
            buildtask(
              updatedAt: today,
              dueAt: fiveDaysAgo,
              createdAt: fiveDaysAgo,
            ),
          ),
          isFalse,
        );
      },
    );
  });
}
