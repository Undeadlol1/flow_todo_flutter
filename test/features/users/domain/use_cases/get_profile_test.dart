import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/get_profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';

class _MockGetProfileRepository extends Mock implements GetProfileRepository {}

class _MockProfileCubit extends Mock implements ProfileCubit {}

const _userId = '123';
final _mockProfileCubit = _MockProfileCubit();
final _mockGetProfileRepository = _MockGetProfileRepository();

void main() {
  setUp(() {
    when(() => _mockProfileCubit.setProfile(profileFixture)).thenReturn(null);

    reset(_mockProfileCubit);
    reset(_mockGetProfileRepository);
  });

  group('GIVEN GetProfile use case', () {
    test(
      'WHEN repository throws an error '
      'THEN returns error',
      () async {
        bool hasCallThrown = false;
        const exceptionMessage = 'Something went wrong';
        final exception = Exception(exceptionMessage);
        when(() => _mockGetProfileRepository(userId: _userId))
            .thenThrow(exception);
        final useCase = _getUseCase();

        try {
          await useCase(userId: _userId);
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
      _mockProfileRepository();

      await _getUseCase().call(userId: _userId);

      verify(() => _mockGetProfileRepository(userId: _userId)).called(1);
    });

    test(
      "WHEN repository returns profile THEN places profile into cubit",
      () async {
        _mockProfileRepository();

        await _getUseCase().call(userId: _userId);

        verify(
          () => _mockProfileCubit.setProfile(profileFixture),
        ).called(1);
      },
    );

    test(
      "WHEN repository returns nothing THEN proper cubit method is called",
      () async {
        when(() => _mockGetProfileRepository(userId: _userId))
            .thenAnswer((_) async => null);

        await _getUseCase().call(userId: _userId);

        verify(() => _mockProfileCubit.setProfileNotFoundOrUnloaded())
            .called(1);
      },
    );
  });
}

GetProfile _getUseCase() {
  return GetProfile(
    profileCubit: _mockProfileCubit,
    getProfileRepository: _mockGetProfileRepository,
  );
}

void _mockProfileRepository() {
  when(() => _mockGetProfileRepository(userId: _userId))
      .thenAnswer((_) async => profileFixture);
}
