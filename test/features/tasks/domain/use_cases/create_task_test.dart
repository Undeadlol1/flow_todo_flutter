import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';

class _MockAddPointsToUser extends Mock implements AddPointsToViewer {}

class _MockCreateTaskRepository extends Mock implements CreateTaskRepository {}

class _FakecUniqueIdGenerator extends Fake implements UniqueIdGenerator {
  @override
  String call() => _uniqueId;
}

class _FakeGetTodaysDate extends Fake implements GetTodaysDate {
  @override
  DateTime call() => _dateToReturn;
}

const _uniqueId = 'unique id 123';
final _tasksCubit = TasksCubit();
final _profileCubit = ProfileCubit();
final _mockAddPointsToUser = _MockAddPointsToUser();
final _fakecUniqueIdGenerator = _FakecUniqueIdGenerator();
final _mockCreateTaskRepository = _MockCreateTaskRepository();
final _dateToReturn = DateTime.now().subtract(const Duration(days: 10));

void main() {
  UniqueIdGenerator;
  const userId = '12313231';
  const taskTitle = 'A title';

  setUp(() {
    reset(_mockCreateTaskRepository);
    registerFallbackValue(taskFixture);
    when((() => _mockCreateTaskRepository(any()))).thenAnswer((_) async {});
  });

  tearDownAll(() {
    _tasksCubit.close();
    _profileCubit.close();
  });

  group('GIVEN CrateTask WHEN called THEN', () {
    test(
      'adds task to state',
      () async {
        final useCase = _buildUseCase();

        await useCase(title: taskTitle, userId: userId);

        expect(_tasksCubit.state.tasks, hasLength(1));
      },
    );

    test(
      'adds points to user',
      () async {
        _profileCubit.setProfile(profileFixture);
        callToAddPointsMock() => _mockAddPointsToUser(10);
        when(() => callToAddPointsMock()).thenAnswer((_) async {});

        await _buildUseCase()(title: taskTitle, userId: userId);

        verify(callToAddPointsMock).called(1);
      },
    );

    test('calls task creation repository', () async {
      final useCase = _buildUseCase();

      await useCase(title: taskTitle, userId: userId);

      verify(() => _mockCreateTaskRepository(captureAny())).called(1);
    });

    test('calls repository with proper task object', () async {
      await _buildUseCase()(title: taskTitle, userId: userId);

      final capturedTask = verify(() => _mockCreateTaskRepository(captureAny()))
          .captured
          .first as Task;
      expect(capturedTask, isA<Task>());
      expect(capturedTask.id, _uniqueId);
      expect(capturedTask.userId, userId);
      expect(capturedTask.isDone, isFalse);
      expect(capturedTask.title, taskTitle);
    });

    test('calls repository with proper dates in the task', () async {
      final millisecondsSinceEpoch = _dateToReturn.millisecondsSinceEpoch;

      await _buildUseCase()(title: taskTitle, userId: userId);

      final taskArgument = verify(() => _mockCreateTaskRepository(captureAny()))
          .captured
          .first as Task;
      expect(taskArgument.dueAt, millisecondsSinceEpoch);
      expect(taskArgument.createdAt, millisecondsSinceEpoch);
    });
  });
}

CreateTask _buildUseCase() {
  return CreateTask(
    tasksCubit: _tasksCubit,
    profileCubit: _profileCubit,
    getTodaysDate: _FakeGetTodaysDate(),
    addPointsToUser: _mockAddPointsToUser,
    uniqueIdGenerator: _fakecUniqueIdGenerator,
    createTaskRepository: _mockCreateTaskRepository,
  );
}
