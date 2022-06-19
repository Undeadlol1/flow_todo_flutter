import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_utilities/mocks/mock_autentification_cubit.dart';
import '../../../../../test_utilities/mocks/mock_firebase_auth.dart';
import '../../../../../test_utilities/mocks/mock_profile_cubit.dart';
import '../../../../../test_utilities/mocks/mock_tasks_cubit.dart';

final _tasksCubit = MockTasksCubit();
final _profileCubit = MockProfileCubit();
final _firebaseAuth = MockFirebasAuth();
final _authentificationCubit = MockAuthentificationCubit();

void main() {
  setUp(() {
    reset(_tasksCubit);
    reset(_profileCubit);
    reset(_firebaseAuth);
    reset(_authentificationCubit);

    when(() => _firebaseAuth.signOut()).thenAnswer((_) async {});
  });

  group('GIVEN Logout WHEN called THEN', () {
    test(
      'removes tasks from tasks cubit',
      _verifyMockCall(() => _tasksCubit.update([])),
    );

    test(
      'clears profile cubit',
      _verifyMockCall(() => _profileCubit.setProfileNotFoundOrUnloaded()),
    );

    test(
      'clears auth cubit',
      _verifyMockCall(
        () => _authentificationCubit.setNotAuthenticated(),
      ),
    );

    test(
      'calls firebase signout method',
      _verifyMockCall(() => _firebaseAuth.signOut()),
    );
  });
}

Future<void> Function() _verifyMockCall(dynamic Function() funcitonToVerify) {
  return () {
    when(funcitonToVerify).thenAnswer((_) async {});

    return _buildUseCase()().then((_) => verify(funcitonToVerify).called(1));
  };
}

Logout _buildUseCase() {
  return Logout(
    tasksCubit: _tasksCubit,
    profileCubit: _profileCubit,
    firebaseAuth: _firebaseAuth,
    authentificationCubit: _authentificationCubit,
  );
}
