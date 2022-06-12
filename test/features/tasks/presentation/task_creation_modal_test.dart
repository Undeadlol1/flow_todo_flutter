import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/user.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/task_creation_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class _MockCreateTask extends Mock implements CreateTask {}

const _userId = '12332randomid';
const taskName = 'A random task name';
final _mockCreateTask = _MockCreateTask();
final _fakeAuthenticatedCubit = AuthentificationCubit()
  ..setUser(
    User(id: _userId, email: 'email', displayName: 'displayName'),
  );

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<CreateTask>(_mockCreateTask);
  });

  group('GIVEN CreateTaskModal', () {
    testWidgets(
      'WHEN text input is submitted '
      'THEN calls use case',
      (tester) async {
        when(_typicalUseCaseCall).thenAnswer((_) async {});

        await _pumpWidget(tester);
        await _submitSomeText(tester);

        verify(_typicalUseCaseCall).called(1);
      },
    );

    testWidgets(
      'WHEN use case throws error '
      'THEN error is displayed',
      (tester) async {
        when(_typicalUseCaseCall).thenThrow(Exception('Any error string'));

        await _pumpWidget(tester);
        await _submitSomeText(tester);

        const errorMessage = 'Something went wrong';
        expect(find.text(errorMessage), findsOneWidget);
      },
    );
  });
}

Future<void> _pumpWidget(WidgetTester tester) {
  return tester.pumpWidget(
    BlocProvider<AuthentificationCubit>(
      create: (context) => _fakeAuthenticatedCubit,
      child: const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: CreateTaskModal()),
        ),
      ),
    ),
  );
}

Future<void> _typicalUseCaseCall() =>
    _mockCreateTask(title: taskName, userId: _userId);

Future<void> _submitSomeText(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField), taskName);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}
