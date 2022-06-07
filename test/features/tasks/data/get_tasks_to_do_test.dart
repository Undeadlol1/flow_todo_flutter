import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

class _MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

final _mockFirestore = _MockFirebaseFirestore();

const _properUserId = 'proper userId';
const _improperUserId = 'should not find this';

void main() {
  test(
    'GIVEN GetTasksToDo '
    'WHEN error was thrown by firestore '
    'THEN returns error',
    () async {
      when(
        () => _mockFirestore
            .collection('tasks')
            .where('userId', isEqualTo: _properUserId)
            .where('isDone', isEqualTo: false)
            .where('dueAt', isLessThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
            .limit(100)
            .get(),
      ).thenThrow(Exception('Something went wrong'));

      expect(
        () => GetTasksToDo(firestore: _mockFirestore).call(userId: ''),
        throwsA(isA<Exception>()),
      );
    },
  );

  group('GIVEN GetTasksToDo WHEN called', () {
    test(
      'THEN returns only single users tasks',
      () async {
        final instance = FakeFirebaseFirestore();
        final collection = instance.collection('tasks');
        await collection.add(_buildTaskMap(userId: _properUserId));
        await collection.add(_buildTaskMap(userId: _properUserId));
        await collection.add(_buildTaskMap(userId: ''));
        await collection.add(_buildTaskMap(userId: _improperUserId));

        final result = await GetTasksToDo(firestore: instance).call(
          userId: _properUserId,
        );

        expect(result, hasLength(2));
      },
    );

    test(
      'THEN returns only not done tasks',
      () async {
        final instance = FakeFirebaseFirestore();
        final collection = instance.collection('tasks');
        await collection.add(_buildTaskMap(userId: _properUserId, isDone: true));
        await collection.add(_buildTaskMap(userId: _properUserId, isDone: false));

        final result = await GetTasksToDo(firestore: instance).call(
          userId: _properUserId,
        );

        expect(result, hasLength(1));
      },
    );

    test(
      'THEN returns only tasks that are due today',
      () async {
        final instance = FakeFirebaseFirestore();
        final collection = instance.collection('tasks');
        final tommorowsDateInMilliseconds =
            DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
        final yesterdaysDateInMilliseconds =
            DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch;

        await collection.add(
          _buildTaskMap(dueAt: tommorowsDateInMilliseconds),
        );
        await collection.add(
          _buildTaskMap(dueAt: yesterdaysDateInMilliseconds),
        );

        final result = await GetTasksToDo(firestore: instance).call(
          userId: _properUserId,
        );

        expect(result, hasLength(1));
      },
    );

    test(
      'THEN returns empty list if nothing have been found',
      () async {
        final instance = FakeFirebaseFirestore();

        final result = await GetTasksToDo(firestore: instance).call(userId: '');

        expect(result, equals([]));
      },
    );
  });
}

Map<String, Object> _buildTaskMap({
  String userId = _properUserId,
  bool isDone = false,
  num? dueAt,
}) {
  final taskConvertedToMap = {
    'isDone': isDone,
    'userId': userId,
    'id': taskFixture.id,
    'title': taskFixture.title,
    'createdAt': taskFixture.createdAt,
    'dueAt': dueAt ?? DateTime.now().millisecondsSinceEpoch,
  };

  return taskConvertedToMap;
}
