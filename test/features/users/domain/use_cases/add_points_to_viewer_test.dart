import 'package:flow_todo_flutter_2022/features/users/data/update_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';

class _MockUpdateProfileRepository extends Mock
    implements UpdateProfileRepository {}

class _MockProfileCubit extends Mock implements ProfileCubit {}

final _mockProfileCubit = _MockProfileCubit();
final _mockUpdateProfileRepository = _MockUpdateProfileRepository();

void main() {
  setUp(() {
    registerFallbackValue(profileFixture);

    reset(_mockProfileCubit);
    reset(_mockUpdateProfileRepository);
  });

  group('GIVEN AddPointsToViewer use case', () {
    test(
      'WHEN repository throws an error '
      'THEN returns error',
      () async {
        final useCase = _getUseCase();
        const exceptionMessage = 'Something went wrong';
        final exception = Exception(exceptionMessage);
        when(() => _mockUpdateProfileRepository(any())).thenThrow(exception);
        _mockLoadedProfile();

        return useCase(10).onError((error, stackTrace) {
          expect(error, isA<Exception>());
          expect(error.toString(), 'Exception: $exceptionMessage');
        });
      },
    );

    test(
      'WHEN repository throws an error '
      'THEN reverts state change',
      () async {
        final useCase = _getUseCase();
        final exception = Exception('Something went wrong');
        when(() => _mockUpdateProfileRepository(any())).thenThrow(exception);
        _mockLoadedProfile();

        return useCase(10).onError((_, __) => {}).whenComplete(
              () => verify(() => _mockProfileCubit.undo()).called(1),
            );
      },
    );

    test('WHEN called THEN calls repository', () async {
      _mockLoadedProfile();
      _mockProfileRepository();

      await _getUseCase()(10);

      final verification = verify(_typicalRepositoryCall);
      verification.called(1);
      expect(verification.captured[0], isA<Profile>());
      expect((verification.captured[0] as Profile).points, 20);
    });

    test(
      'WHEN profile state is not loaded '
      'THEN returns error',
      () async {
        bool hasCallThrown = false;
        final useCase = _getUseCase();
        const exceptionMessage = 'Profile not loaded';
        _mockProfileRepository();
        when(() => _mockProfileCubit.state).thenReturn(ProfileLoading());

        try {
          await useCase(10);
        } catch (error) {
          hasCallThrown = true;

          expect(error, isA<Exception>());
          expect(error.toString(), 'Exception: $exceptionMessage');
        } finally {
          expect(hasCallThrown, isTrue);
        }
      },
    );

    test("WHEN called THEN updates profile cubit", () async {
      _mockLoadedProfile();
      _mockProfileRepository();

      await _getUseCase()(10);

      verify(
        () => _mockProfileCubit.setProfile(
          profileFixture.copyWith(
            points: 20,
            experience: 20,
          ),
        ),
      ).called(1);
    });
  });
}

void _mockLoadedProfile() {
  when(() => _mockProfileCubit.state).thenReturn(
    ProfileLoaded(
      profile: profileFixture.copyWith(points: 10, experience: 10),
    ),
  );
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
