import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/get_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetProfileRepository extends Mock implements GetProfileRepository {}

void main() {
  const userId = '123';
  final mockGetProfileRepository = _MockGetProfileRepository();

  setUp(() {
    reset(mockGetProfileRepository);
  });

  group('GIVEN GetProfile use case', () {
    test(
      'WHEN repository throws an error '
      'THEN returns error',
      () async {
        bool hasCallThrown = false;
        const exceptionMessage = 'Something went wrong';
        final exception = Exception(exceptionMessage);
        when(() => mockGetProfileRepository(userId: userId))
            .thenThrow(exception);
        final useCase =
            GetProfile(getProfileRepository: mockGetProfileRepository);

        try {
          await useCase(userId: userId);
        } catch (error) {
          hasCallThrown = true;

          expect(error, isA<Exception>());
          expect(error.toString(), 'Exception: $exceptionMessage');
        } finally {
          expect(hasCallThrown, isTrue);
        }
      },
    );

    test('WHEN called THEN calls repository', () async {
      when(() => mockGetProfileRepository(userId: userId))
          // TODO extract profile into fixture.
          .thenAnswer((_) async => Profile(
                id: 'id',
                userId: 'userId',
                createdAt: 0,
                areEcouragingMessagesDisabled: false,
              ));

      await GetProfile(getProfileRepository: mockGetProfileRepository)
          .call(userId: userId);

      verify(() => mockGetProfileRepository(userId: userId)).called(1);
    });
  });
}
