import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_history_fixture.dart';

void main() {
  group(
    'GIVEN Task',
    () {
      test(
        'WHEN object is parsed from json '
        'THEN mandatory dates must be type of DateTime',
        () {
          final json = taskFixture.toJson();

          final task = Task.fromJson(json);

          final dateMatcher = allOf([isA<DateTime>(), isNot(0)]);
          expect(task.dueAt, dateMatcher);
          expect(task.createdAt, dateMatcher);
        },
      );

      group('WHEN object is parsed to JSON', () {
        test(
          'THEN mandatory dates must be integers',
          () {
            final json = taskFixture.toJson();

            final integerMatcher = allOf([isA<int>(), isNot(0)]);
            expect(json['dueAt'], integerMatcher, reason: 'dueAt formatting');
            expect(
              json['createdAt'],
              integerMatcher,
              reason: 'createdAt formatting',
            );
          },
        );

        test(
          'THEN history property should be serialised properly',
          () {
            final result =
                taskFixture.copyWith(history: [taskHistoryFixture]).toJson();

            expect(result['history'], hasLength(1));
            expect(result['history'][0], isA<Map>());
            expect(result['history'][0]['actionType'], isA<String>());
          },
        );
      });
    },
  );
}
