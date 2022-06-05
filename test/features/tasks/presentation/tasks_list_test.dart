import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

void main() {
  group('GIVEN TasksList', () {
    testWidgets(
      'WHEN there are no tasks '
      'THEN displays nothing',
      (tester) async {
        final cubit = TasksCubit()..update([]);

        await tester.pumpWithDependencies(
          tasksCubit: cubit,
          child: const TasksList(),
        );

        expect(find.byType(TasksListItem), findsNothing);
      },
    );

    group('WHEN there are two tasks', () {
      testWidgets(
        'THEN displays 2 TasksListItem',
        (tester) async {
          final cubit = TasksCubit()..update([taskFixture, taskFixture]);

          await tester.pumpWithDependencies(
            tasksCubit: cubit,
            child: const TasksList(),
          );

          expect(find.byType(TasksListItem), findsNWidgets(2));
        },
      );
    });
  });
}

extension on WidgetTester {
  Future<void> pumpWithDependencies({
    required Widget child,
    required TasksCubit tasksCubit,
  }) {
    // ignore: unnecessary_this
    return this.pumpWidget(
      BlocProvider(
        create: (context) => tasksCubit,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: child,
        ),
      ),
    );
  }
}
