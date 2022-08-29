import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/user.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/update_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/create_task_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
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
    GetIt.I.registerSingleton<CreateTask>(_mockCreateTask);
    GetIt.I.registerSingleton<UpdateTask>(_mockUpdateTask);
    GetIt.I.registerSingleton<SnackbarService>(MockSnackbarService());

    when(_typicaTaskUpdateCall).thenAnswer(Future.value);
    when(_typicalTaskCreateCall).thenAnswer(Future.value);
  });

  group('GIVEN CreateTaskForm', () {
    testWidgets(
      'WHEN text input is submitted THEN creates task',
      (tester) async {
        await tester.pumpAndSumbitSomeText();

        verify(_typicalTaskCreateCall).called(1);
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
              child: CreateTaskForm(
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
  Future<void> pumpAndSumbitSomeText({bool shouldUpdateTask = false}) async {
    await pumpWithDependencies(shouldUpdateTask: shouldUpdateTask);
    await _submitSomeText(this);
  }
}

Future<void> _submitSomeText(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField), taskName);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}

Future<void> _typicalTaskCreateCall() =>
    _mockCreateTask(title: taskName, userId: _userId);

Future<void> _typicaTaskUpdateCall() =>
    _mockUpdateTask(taskFixture.copyWith(title: taskName));
