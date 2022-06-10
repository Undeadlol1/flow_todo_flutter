import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class _MockCreateTaskRepository extends Mock implements CreateTaskRepository {}

final _mockCreateTaskRepository = _MockCreateTaskRepository();

void main() {
  final tasksCubit = TasksCubit();
  const userId = '12313231';
  const taskTitle = 'A title';
  final taskToBeCreated = Task(
    id: Uuid().v4(),
    createdAt: 0,
    dueAt: 0,
    history: [],
    isDone: false,
    tags: [],
    title: taskTitle,
    userId: userId,
  );

  setUpAll(() {
    registerFallbackValue(taskToBeCreated);
  });

  tearDownAll(tasksCubit.close);

  group('GIVEN CrateTask WHEN called THEN', () {
    // test("sets id properly", () async {
    //   final useCase = CreateTask(
    //     tasksCubit: tasksCubit,
    //     createTaskRepository: _mockCreateTaskRepository,
    //   );

    //   await useCase(title: taskTitle, userId: userId);

    //   expect(, matcher)
    // });

    // test(
    //   'adds task to state',
    //   () async {
    //     final useCase = CreateTask(
    //       tasksCubit: tasksCubit,
    //       createTaskRepository: _mockCreateTaskRepository,
    //     );

    //     await useCase(title: taskTitle, userId: userId);

    //     expect(tasksCubit.state.tasks, hasLength(1));
    //   },
    // );
    test('calls task creation repository', () async {
      when((() => _mockCreateTaskRepository(any()))).thenAnswer((_) async {});
      final useCase = CreateTask(
        tasksCubit: tasksCubit,
        createTaskRepository: _mockCreateTaskRepository,
      );

      await useCase(title: taskTitle, userId: userId);

      verify(() => _mockCreateTaskRepository(captureAny())).called(1);
    });

    test('calls repository with proper arguments', () async {
      when((() => _mockCreateTaskRepository(any()))).thenAnswer((_) async {});
      final useCase = CreateTask(
        tasksCubit: tasksCubit,
        createTaskRepository: _mockCreateTaskRepository,
      );

      await useCase(title: taskTitle, userId: userId);

      final capturedArguments =
          verify(() => _mockCreateTaskRepository(captureAny())).captured;
      final capturedTaskArgument = capturedArguments.first as Task;
      expect(
        capturedArguments.isNotEmpty,
        isTrue,
        reason: 'No arguments captured',
      );
      expect(capturedTaskArgument, isA<Task>());
      expect(capturedTaskArgument.isDone, isFalse);
      expect(capturedTaskArgument.userId, userId);
    });
  });
}
