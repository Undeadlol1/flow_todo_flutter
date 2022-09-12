import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_remote_config_cubit.dart';

void main() {
  final today = DateTime.now();
  final MockRemoteConfigCubit remoteConfigCubit = MockRemoteConfigCubit();
  final detector = StaleTaskDetector(remoteConfigCubit: remoteConfigCubit);
  final fiveDaysAgo = today.subtract(const Duration(days: 5));

  Task buildtask({
    DateTime? createdAt,
    DateTime? dueAt,
    DateTime? updatedAt,
  }) {
    return taskFixture.copyWith(
      updatedAt: updatedAt,
      dueAt: dueAt ?? today,
      createdAt: createdAt ?? today,
    );
  }

  group('GIVEN StaleTaskDetector', () {
    setUpAll(
      () => when(() => remoteConfigCubit.state).thenReturn(
        RemoteConfigState.defaults().copyWith(isStaleDetectionEnabled: true),
      ),
    );

    test(
      'WHEN task wasn\'t worked on after creation '
      'THEN returns true',
      () {
        expect(
          detector.isStale(buildtask(createdAt: fiveDaysAgo)),
          isTrue,
        );
      },
    );

    test(
      'WHEN task wasn\'t worked on when it is due '
      'THEN returns true',
      () {
        expect(detector.isStale(buildtask(dueAt: fiveDaysAgo)), isTrue);
      },
    );

    test(
      'WHEN task is old but was updated '
      'THEN returns false',
      () {
        expect(
          detector.isStale(
            buildtask(
              updatedAt: today,
              dueAt: fiveDaysAgo,
              createdAt: fiveDaysAgo,
            ),
          ),
          isFalse,
        );
      },
    );

    test(
      'WHEN remote config disables stale detection'
      'THEN returns false',
      () {
        when(() => remoteConfigCubit.state).thenReturn(
          RemoteConfigState.defaults().copyWith(isStaleDetectionEnabled: true),
        );

        expect(
          detector.isStale(
            buildtask(createdAt: fiveDaysAgo),
          ),
          isTrue,
        );

        when(() => remoteConfigCubit.state).thenReturn(
          RemoteConfigState.defaults().copyWith(isStaleDetectionEnabled: false),
        );

        expect(
          detector.isStale(
            buildtask(createdAt: fiveDaysAgo),
          ),
          isFalse,
        );
      },
    );
  });
}
