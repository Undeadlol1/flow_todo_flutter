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

    when((() => _firebaseAuth.signOut())).thenAnswer((_) async {});
  });

  group('GIVEN Logout WHEN called THEN', () {
    testWidgets('removes tasks from tasks cubit', (tester) async {
      when(() => _tasksCubit.update([])).thenReturn(null);

      await _buildUseCase()();

      verify(() => _tasksCubit.update([])).called(1);
    });

    testWidgets('clears profile cubit', (tester) async {
      when(() => _profileCubit.setProfileNotFoundOrUnloaded()).thenReturn(null);

      await _buildUseCase()();

      verify(() => _profileCubit.setProfileNotFoundOrUnloaded()).called(1);
    });

    testWidgets('clears auth cubit', (tester) async {
      when(() => _authentificationCubit.setNotAuthenticated()).thenReturn(null);

      await _buildUseCase()();

      verify(() => _authentificationCubit.setNotAuthenticated()).called(1);
    });

    testWidgets('calls firebase signout method', (tester) async {
      when((() => _firebaseAuth.signOut())).thenAnswer((_) async {});

      await _buildUseCase()();

      verify(() => _firebaseAuth.signOut()).called(1);
    });
  });
}

Logout _buildUseCase() {
  return Logout(
    tasksCubit: _tasksCubit,
    profileCubit: _profileCubit,
    firebaseAuth: _firebaseAuth,
    authentificationCubit: _authentificationCubit,
  );
}
