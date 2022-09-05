import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/update_task_note.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture_2.dart';
import '../../../../test_utilities/mocks/mock_tasks_cubit.dart';
import '../../../../test_utilities/mocks/mock_update_task_repository.dart';

void main() {
  final tasksCubit = MockTasksCubit();
  final mockUpdateTaskRepository = MockUpdateTaskRepository();

  const updatedNoteText = 'A new note to be inserted to task';
  final updatedtask = taskFixture.copyWith(note: updatedNoteText);

  typicallRepositoryCall() => mockUpdateTaskRepository(updatedtask);
  typicallCubitCall() =>
      tasksCubit.updateTask(taskFixture.copyWith(note: updatedNoteText));

  UpdateTaskNote getUseCase() {
    return UpdateTaskNote(
      updateTaskRepository: mockUpdateTaskRepository,
      tasksCubit: tasksCubit,
    );
  }

  setUp(() {
    when(() => tasksCubit.state).thenReturn(
      TasksState.loaded([taskFixture, taskFixture2]),
    );
    when(typicallCubitCall).thenReturn(null);
    when(typicallRepositoryCall).thenAnswer((_) async {});
  });

  tearDown(() {
    reset(tasksCubit);
    clearInteractions(tasksCubit);
  });

  group('GIVEN UpdateTaskNote', () {
    test('WHEN is called THEN calls update repository', () async {
      await getUseCase()(task: taskFixture, note: updatedNoteText);

      verify(typicallRepositoryCall).called(1);
    });

    test('WHEN is called THEN updates the task in tasks cubit', () async {
      await getUseCase()(task: taskFixture, note: updatedNoteText);

      verify(typicallCubitCall).called(1);
    });
  });
}
