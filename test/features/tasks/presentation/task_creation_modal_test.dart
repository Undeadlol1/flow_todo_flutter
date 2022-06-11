import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/user.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/task_creation_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reactive_forms/reactive_forms.dart';

class _MockCreateTask extends Mock implements CreateTask {}

const _userId = '12332randomid';
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
        const taskName = 'A random task name';
        when(() => _mockCreateTask(title: taskName, userId: _userId))
            .thenAnswer((_) async {});

        await tester.pumpWidget(
          BlocProvider<AuthentificationCubit>(
            create: (context) => _fakeAuthenticatedCubit,
            child: const MaterialApp(
              home: Scaffold(
                body: SingleChildScrollView(child: CreateTaskModal()),
              ),
            ),
          ),
        );
        await tester.enterText(find.byType(TextField), taskName);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        verify(() => _mockCreateTask(title: taskName, userId: _userId))
            .called(1);
      },
    );
  });
}
