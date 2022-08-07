import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/get_profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/mocks/mock_profile_cubit.dart';
import '../../../../test_utilities/mocks/mock_use_case_exception_handler.dart';

class _MockGetProfileRepository extends Mock implements GetProfileRepository {}

const _userId = '123';
final _mockProfileCubit = MockProfileCubit();
final _mockGetProfileRepository = _MockGetProfileRepository();

void main() {
  setUp(() {
    reset(_mockProfileCubit);
    reset(_mockGetProfileRepository);

    _mockCubitWithLoadedProfile();
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
    useCaseExceptionHandler: MockUseCaseExceptionHandler(),
  );
}

void _mockProfileRepository() {
  when(() => _mockGetProfileRepository(userId: _userId))
      .thenAnswer((_) async => profileFixture);
}

void _mockCubitWithLoadedProfile() {
  final profileLoadedState = ProfileLoaded(
    profile: profileFixture.copyWith(
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    ),
  );
  when(() => _mockProfileCubit.state).thenReturn(profileLoadedState);
  when(() => _mockProfileCubit.stream)
      .thenAnswer((_) => Stream.fromIterable([profileLoadedState]));
  when(() => _mockProfileCubit.close()).thenAnswer((_) async => {});
}
