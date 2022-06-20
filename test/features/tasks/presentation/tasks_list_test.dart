import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/pagination.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_list.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

void main() {
  group('GIVEN TasksList', () {
    testWidgets(
      'WHEN there are no tasks '
      'THEN displays nothing',
      (tester) async {
        final cubit = TasksCubit()..updateList([]);

        await tester.pumpWithDependencies(
          tasksCubit: cubit,
          child: const TasksList(),
        );

        expect(find.byType(TasksListItem), findsNothing);
      },
    );

    group('WHEN there tasks tasks', () {
      testWidgets(
        'THEN displays exact number of TasksListItem',
        (tester) async {
          final cubit = TasksCubit()..updateList([taskFixture, taskFixture]);

          await tester.pumpWithDependencies(
            tasksCubit: cubit,
            child: const TasksList(),
          );

          expect(find.byType(TasksListItem), findsNWidgets(2));
        },
      );

      testWidgets(
        "THEN displays pagination",
        (WidgetTester tester) async {
          final cubit = TasksCubit()..updateList([taskFixture, taskFixture]);

          await tester.pumpWithDependencies(
            tasksCubit: cubit,
            child: const TasksList(),
          );

          expect(find.byType(Pagination), findsOneWidget);
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
    if (GetIt.I.isRegistered<TasksCubit>()) {
      tasksCubit.close();
      GetIt.I.unregister<TasksCubit>();
    }
    GetIt.I.registerSingleton(tasksCubit);

    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => tasksCubit,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
