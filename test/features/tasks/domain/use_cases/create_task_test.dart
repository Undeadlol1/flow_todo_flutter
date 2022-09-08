import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_firebase_analytics.dart';
import '../../../../test_utilities/mocks/mock_use_case_exception_handler.dart';
import '../../../../test_utilities/mocks/setupers/setup_profiile_cubit_mock.dart';
import '../../../../test_utilities/mocks/setupers/setup_tasks_to_do_cubit._mock.dart';

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

late TasksToDoCubit _mockTasksCubit;
late ProfileCubit _mockProfileCubit;

final _mockAddPointsToUser = _MockAddPointsToUser();
final _mockFirebaseAnalytics = MockFirebaseAnalytics();
final _fakecUniqueIdGenerator = _FakecUniqueIdGenerator();
final _mockCreateTaskRepository = _MockCreateTaskRepository();
final _mockUseCaseExceptionHandler = MockUseCaseExceptionHandler();
final _dateToReturn = DateTime.now().subtract(const Duration(days: 10));

void main() {
  UniqueIdGenerator;
  const userId = '12313231';
  const taskTitle = 'A title';

  callToAddPointsMock() => _mockAddPointsToUser(10);

  setUpAll(() {
    registerFallbackValue([]);

    _mockTasksCubit = setupTasksToDoCubitMock();
    _mockProfileCubit = setupProfileCubitMock();

    when(() => _mockFirebaseAnalytics.logEvent(name: any(named: 'name')))
        .thenAnswer((_) async {});
  });

  setUp(() {
    reset(_mockAddPointsToUser);
    reset(_mockCreateTaskRepository);

    registerFallbackValue(taskFixture);

    when(() => callToAddPointsMock()).thenAnswer((_) async {});
    when(() => _mockCreateTaskRepository(any())).thenAnswer((_) async {});
  });

  group('GIVEN CrateTask WHEN called THEN', () {
    test(
      'adds task to state',
      () async {
        when(() => _mockTasksCubit.updateList(any())).thenReturn(null);

        await _buildUseCase()(title: taskTitle, userId: userId, tags: []);

        final verificatiion =
            verify(() => _mockTasksCubit.updateList(captureAny()));
        verificatiion.called(1);
        expect(verificatiion.captured[0], hasLength(1));
        expect(verificatiion.captured[0][0], isA<Task>());
      },
    );

    test(
      'adds points to user',
      () async {
        _mockProfileCubit.setProfile(profileFixture);

        await _buildUseCase()(title: taskTitle, userId: userId, tags: []);

        verify(callToAddPointsMock).called(1);
      },
    );

    test('calls task creation repository', () async {
      final useCase = _buildUseCase();

      await useCase(title: taskTitle, userId: userId, tags: []);

      verify(() => _mockCreateTaskRepository(captureAny())).called(1);
    });

    test('calls repository with proper task object', () async {
      await _buildUseCase()(title: taskTitle, userId: userId, tags: []);

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
      await _buildUseCase()(title: taskTitle, userId: userId, tags: []);

      final taskArgument = verify(() => _mockCreateTaskRepository(captureAny()))
          .captured
          .first as Task;
      expect(taskArgument.dueAt, _dateToReturn);
      expect(taskArgument.createdAt, _dateToReturn);
    });
  });
}

CreateTask _buildUseCase() {
  return CreateTask(
    tasksCubit: _mockTasksCubit,
    profileCubit: _mockProfileCubit,
    getTodaysDate: _FakeGetTodaysDate(),
    addPointsToUser: _mockAddPointsToUser,
    firebaseAnalytics: _mockFirebaseAnalytics,
    uniqueIdGenerator: _fakecUniqueIdGenerator,
    createTaskRepository: _mockCreateTaskRepository,
    useCaseExceptionHandler: _mockUseCaseExceptionHandler,
  );
}
