import 'package:flow_todo_flutter_2022/features/users/data/update_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUpdateProfileRepository extends Mock
    implements UpdateProfileRepository {}

class _MockProfileCubit extends Mock implements ProfileCubit {}

const _userId = '123';
final _mockProfileCubit = _MockProfileCubit();
final _mockUpdateProfileRepository = _MockUpdateProfileRepository();

// TODO extract profile into fixture.
final _profileFixture = Profile(
  id: 'id',
  userId: 'userId',
  createdAt: 0,
  // TODO make points 0 by default.
  points: 10,
  areEcouragingMessagesDisabled: false,
);

void main() {
  setUp(() {
    registerFallbackValue(_profileFixture);

    reset(_mockProfileCubit);
    reset(_mockUpdateProfileRepository);
  });

  group('GIVEN AddPointsToViewer use case', () {
    test(
      'WHEN repository throws an error '
      'THEN returns error',
      () async {
        bool hasCallThrown = false;
        final useCase = _getUseCase();
        const exceptionMessage = 'Something went wrong';
        final exception = Exception(exceptionMessage);
        when(() => _mockUpdateProfileRepository(any())).thenThrow(exception);

        try {
          await useCase(profile: _profileFixture, pointsToAdd: 10);
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

      await _getUseCase()(profile: _profileFixture, pointsToAdd: 10);

      final verification = verify(_typicalRepositoryCall);
      verification.called(1);
      expect(verification.captured[0], isA<Profile>());
      expect((verification.captured[0] as Profile).points, 20);
    });

    test(
      "WHEN called THEN updates profile cubit",
      () async {
        _mockProfileRepository();

        await _getUseCase()(profile: _profileFixture, pointsToAdd: 10);

        verify(
          () => _mockProfileCubit
              .setProfile(_profileFixture.copyWith(points: 20)),
        ).called(1);
      },
    );

    // test(
    //   "WHEN repository returns nothing THEN proper cubit method is called",
    //   () async {
    //     when(() => _mockUpdateProfileRepository(userId: _userId))
    //         .thenAnswer((_) async => null);

    //     await _getUseCase().call(userId: _userId);

    //     verify(() => _mockProfileCubit.setProfileNotFound()).called(1);
    //   },
    // );
  });
}

AddPointsToViewer _getUseCase() {
  return AddPointsToViewer(
    profileCubit: _mockProfileCubit,
    updateProfileRepository: _mockUpdateProfileRepository,
  );
}

void _mockProfileRepository() {
  when(_typicalRepositoryCall).thenAnswer((_) async {});
}

Future<void> _typicalRepositoryCall() =>
    _mockUpdateProfileRepository(captureAny());
