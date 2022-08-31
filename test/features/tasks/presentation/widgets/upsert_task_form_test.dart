import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/user.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/update_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/upsert_task_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_firebase_remote_config.dart';
import '../../../../test_utilities/mocks/mock_snackbar_service.dart';

class _MockCreateTask extends Mock implements CreateTask {}

class _MockUpdateTask extends Mock implements UpdateTask {}

class _MockNavigatorObserver extends Mock implements NavigatorObserver {}

const _userId = '12332randomid';
const taskName = 'A random task name';
final _mockCreateTask = _MockCreateTask();
final _mockUpdateTask = _MockUpdateTask();
final _fakeAuthenticatedCubit = AuthentificationCubit()
  ..setUser(
    User(id: _userId, email: 'email', displayName: 'displayName'),
  );

void main() {
  setUpAll(() {
    final mockFirebaseRemoteConfig = MockFirebaseRemoteConfig();

    GetIt.I.registerSingleton<CreateTask>(_mockCreateTask);
    GetIt.I.registerSingleton<UpdateTask>(_mockUpdateTask);
    GetIt.I.registerSingleton<SnackbarService>(MockSnackbarService());
    GetIt.I.registerSingleton<FirebaseRemoteConfig>(mockFirebaseRemoteConfig);

    when(_typicaTaskUpdateCall).thenAnswer(Future.value);
    when(_typicalTaskCreateCall).thenAnswer(Future.value);
    when(() => mockFirebaseRemoteConfig.getBool(any())).thenReturn(false);
  });

  group('GIVEN UpsertTaskForm', () {
    testWidgets(
      'WHEN text input is submitted THEN creates task',
      (tester) async {
        await tester.pumpAndSumbitSomeText();

        verify(_typicalTaskCreateCall).called(1);
      },
    );

    testWidgets(
      'WHEN text submitted with tags '
      'THEN calls use case with proper arguments',
      (tester) async {
        const firstTag = 'FirstTag';
        const secondTag = 'SecondTag';
        final tags = [firstTag.toLowerCase(), secondTag.toLowerCase()];

        await tester.pumpAndSumbitSomeText(
          text: '$taskName #$firstTag #$secondTag',
        );

        verify(
          () => _mockCreateTask.call(
            tags: tags,
            title: taskName,
            userId: _userId,
          ),
        ).called(1);
      },
    );

    testWidgets(
      'WHEN text input is submitted '
      'AND taskToUpdate argument is provided '
      'THEN updates the task',
      (tester) async {
        await tester.pumpAndSumbitSomeText(shouldUpdateTask: true);

        verify(_typicaTaskUpdateCall).called(1);
        verifyNever(_typicalTaskCreateCall);
      },
    );

    testWidgets(
      'WHEN use case throws error THEN error is displayed',
      (tester) async {
        final exception = Exception('Any error string');
        when(_typicalTaskCreateCall).thenThrow(exception);

        await tester.pumpAndSumbitSomeText();

        expect(find.text(exception.toString()), findsOneWidget);
      },
    );
  });
}

extension on WidgetTester {
  Future<void> pumpWithDependencies({bool shouldUpdateTask = false}) async {
    return pumpWidget(
      BlocProvider<AuthentificationCubit>(
        create: (context) => _fakeAuthenticatedCubit,
        child: MaterialApp(
          navigatorObservers: [_MockNavigatorObserver()],
          home: Scaffold(
            body: SingleChildScrollView(
              child: UpsertTaskForm(
                taskToUpdate: shouldUpdateTask ? taskFixture : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on WidgetTester {
  Future<void> pumpAndSumbitSomeText({
    String text = taskName,
    bool shouldUpdateTask = false,
  }) async {
    await pumpWithDependencies(shouldUpdateTask: shouldUpdateTask);
    await _submitSomeText(tester: this, text: text);
  }
}

Future<void> _submitSomeText({
  required String text,
  required WidgetTester tester,
}) async {
  await tester.enterText(find.byType(TextField), text);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}

Future<void> _typicalTaskCreateCall() =>
    _mockCreateTask(title: taskName, userId: _userId, tags: []);

Future<void> _typicaTaskUpdateCall() =>
    _mockUpdateTask(taskFixture.copyWith(title: taskName));
