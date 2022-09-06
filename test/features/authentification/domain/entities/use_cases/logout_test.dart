import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_utilities/mocks/mock_autentification_cubit.dart';
import '../../../../../test_utilities/mocks/mock_firebase_auth.dart';
import '../../../../../test_utilities/mocks/mock_profile_cubit.dart';
import '../../../../../test_utilities/mocks/mock_remote_config_cubit.dart';
import '../../../../../test_utilities/mocks/mock_filter_by_tags_cubit.dart';
import '../../../../../test_utilities/mocks/mock_tasks_cubit.dart';
import '../../../../../test_utilities/mocks/mock_tasks_worked_on_today_cubit.dart';

final _tagsCubit = MockFilterByTagsCubit();
final _tasksCubit = MockTasksCubit();
final _firebaseAuth = MockFirebasAuth();
final _profileCubit = MockProfileCubit();
final _tasksDoneTodayCubit = MockTasksWorkedOnTodayCubit();
final _authentificationCubit = MockAuthentificationCubit();

class _MockFirebaseFirestore extends Mock implements FirebaseFirestore {
  @override
  Future<void> clearPersistence() {
    return Future.value(null);
  }
}

void main() {
  setUp(() {
    reset(_tagsCubit);
    reset(_tasksCubit);
    reset(_profileCubit);
    reset(_firebaseAuth);
    reset(_authentificationCubit);
    reset(_tasksDoneTodayCubit);

    when(() => _firebaseAuth.signOut()).thenAnswer((_) async {});
  });

  group('GIVEN Logout WHEN called THEN', () {
    test(
      'removes tasks from tasks cubit',
      _verifyMockCall(() => _tasksCubit.updateList([])),
    );

    test(
      'clears profile cubit',
      _verifyMockCall(() => _profileCubit.setProfileNotFoundOrUnloaded()),
    );

    test(
      'clears auth cubit',
      _verifyMockCall(() => _authentificationCubit.setNotAuthenticated()),
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
    tagsCubit: _tagsCubit,
    tasksCubit: _tasksCubit,
    profileCubit: _profileCubit,
    firebaseAuth: _firebaseAuth,
    tasksDoneTodayCubit: _tasksDoneTodayCubit,
    remoteConfigCubit: MockRemoteConfigCubit(),
    firebaseFirestore: _MockFirebaseFirestore(),
    authentificationCubit: _authentificationCubit,
  );
}
