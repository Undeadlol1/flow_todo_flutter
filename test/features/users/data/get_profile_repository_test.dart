import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

const _userId = 'proper userId';

void main() {
  group('GIVEN GetProfileRepository', () {
    test(
      'WHEN error was thrown by firestore THEN returns error',
      () async {
        final mockFirestore = _MockFirebaseFirestore();
        when(_typicalFirestoreCall(mockFirestore))
            .thenThrow(Exception('Something went wrong'));

        expect(
          () => GetProfileRepository(firestore: mockFirestore).call(userId: ''),
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      'WHEN called '
      'THEN constructs query to firestore properly',
      () async {
        final mockFirestore = _MockFirebaseFirestore();
        when(_typicalFirestoreCall(mockFirestore)).thenAnswer(
            (_) => null as Future<QuerySnapshot<Map<String, dynamic>>>);

        try {
          await GetProfileRepository(firestore: mockFirestore)
              .call(userId: _userId);
        } catch (e) {
          verify(_typicalFirestoreCall(mockFirestore)).called(1);
        }
      },
    );

    test(
      "WHEN profile does not exist "
      "THEN returns null",
      () async {
        final instance = FakeFirebaseFirestore();

        final result = await GetProfileRepository(firestore: instance)
            .call(userId: _userId);

        expect(result, isNull);
      },
    );

    test(
      'WHEN called THEN returns proper document',
      () async {
        final profileToReturn = Profile(
          id: _userId,
          createdAt: 0,
          userId: _userId,
          areEcouragingMessagesDisabled: false,
        );
        final instance = FakeFirebaseFirestore();
        final collection = instance.collection('profiles');
        await collection.doc(_userId).set(profileToReturn.toJson());

        final result = await GetProfileRepository(firestore: instance).call(
          userId: _userId,
        );

        expect(result, isA<Profile>());
        expect(result?.id, _userId);
        expect(result?.userId, _userId);
      },
    );
  });
}

_typicalFirestoreCall(_MockFirebaseFirestore mockFirestore) {
  return () {
    return mockFirestore.collection('profiles').doc(_userId).get();
  };
}
