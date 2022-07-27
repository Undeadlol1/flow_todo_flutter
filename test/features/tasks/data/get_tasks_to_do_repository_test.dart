import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

class _MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

const _properUserId = 'proper userId';
const _improperUserId = 'should not find this';

void main() {
  test(
    'GIVEN GetTasksToDoRepository '
    'WHEN error was thrown by firestore '
    'THEN returns error',
    () async {
      final mockFirestore = _MockFirebaseFirestore();
      when(_typicalFirestoreCall(mockFirestore))
          .thenThrow(Exception('Something went wrong'));

      expect(
        () => GetTasksToDoRepository(firestore: mockFirestore).call(userId: ''),
        throwsA(isA<Exception>()),
      );
    },
  );

  test(
    'GIVEN GetTasksToDoRepository '
    'WHEN called '
    'THEN constructs query to firestore properly',
    () async {
      final mockFirestore = _MockFirebaseFirestore();

      when(_typicalFirestoreCall(mockFirestore)).thenAnswer(
        (_) => null as Future<QuerySnapshot<Map<String, dynamic>>>,
      );

      try {
        await GetTasksToDoRepository(firestore: mockFirestore)
            .call(userId: _properUserId);
      } catch (e) {
        verify(_typicalFirestoreCall(mockFirestore)).called(1);
      }
    },
  );

  group('GIVEN GetTasksToDoRepository WHEN called', () {
    test(
      'THEN returns only single users tasks',
      () async {
        final instance = FakeFirebaseFirestore();
        final collection = instance.collection('tasks');
        await collection
            .add(_buildTaskMap(userId: _properUserId))
            .then((_) => collection.add(_buildTaskMap(userId: _properUserId)))
            .then((_) => collection.add(_buildTaskMap(userId: '')))
            .then(
              (_) => collection.add(_buildTaskMap(userId: _improperUserId)),
            );

        final result = await GetTasksToDoRepository(firestore: instance).call(
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
        await collection
            .add(_buildTaskMap(userId: _properUserId, isDone: true))
            .then(
              (_) => collection
                  .add(_buildTaskMap(userId: _properUserId, isDone: false)),
            );

        final result = await GetTasksToDoRepository(firestore: instance).call(
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
        final yesterdaysDateInMilliseconds = DateTime.now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch;

        await collection
            .add(_buildTaskMap(dueAt: tommorowsDateInMilliseconds))
            .then(
              (_) => collection
                  .add(_buildTaskMap(dueAt: yesterdaysDateInMilliseconds)),
            );

        final result = await GetTasksToDoRepository(firestore: instance).call(
          userId: _properUserId,
        );

        expect(result, hasLength(1));
      },
    );

    test(
      'THEN returns empty list if nothing have been found',
      () async {
        final instance = FakeFirebaseFirestore();

        final result =
            await GetTasksToDoRepository(firestore: instance).call(userId: '');

        expect(result, equals([]));
      },
    );
  });
}

_typicalFirestoreCall(_MockFirebaseFirestore mockFirestore) {
  return () {
    const userId = _properUserId;
    return mockFirestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('isDone', isEqualTo: false)
        .where(
          'dueAt',
          isLessThanOrEqualTo: DateTime.now().millisecondsSinceEpoch,
        )
        .limit(100)
        .get();
  };
}

Map<String, Object> _buildTaskMap({
  String userId = _properUserId,
  bool isDone = false,
  int? dueAt,
}) {
  final taskConvertedToMap = {
    'isDone': isDone,
    'userId': userId,
    'id': taskFixture.id,
    'name': taskFixture.title,
    'createdAt': taskFixture.createdAt.millisecondsSinceEpoch,
    'dueAt': dueAt ?? DateTime.now().millisecondsSinceEpoch,
  };

  return taskConvertedToMap;
}
