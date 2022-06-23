import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

class _MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('GIVEN UpdateTaskRepository', () {
    test(
      'WHEN error was thrown by firestore THEN returns error',
      () async {
        final mockFirestore = _MockFirebaseFirestore();
        when(_typicalFirestoreCall(mockFirestore))
            .thenThrow(Exception('Something went wrong'));

        expect(
          () {
            return UpdateTaskRepository(firestore: mockFirestore)
                .call(taskFixture);
          },
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      'WHEN called THEN updates "isDone" property',
      () async {
        final updatedTaskInDB = taskFixture.id;
        final mockFirestore = FakeFirebaseFirestore();
        final collection = mockFirestore.collection('tasks');
        final initialTask = taskFixture.copyWith(isDone: false);
        final updatedTask = taskFixture.copyWith(isDone: true);
        await collection.add(initialTask.toJson());

        await UpdateTaskRepository(firestore: mockFirestore).call(updatedTask);

        final createdTaskInDB = await collection.doc(updatedTaskInDB).get();
        expect(createdTaskInDB.get('isDone'), isTrue);
      },
    );
  });
}

_typicalFirestoreCall(_MockFirebaseFirestore mockFirestore) {
  return () {
    return mockFirestore
        .collection('tasks')
        .doc(taskFixture.id)
        .set(taskFixture.toJson());
  };
}
