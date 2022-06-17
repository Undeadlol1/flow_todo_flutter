import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_done_today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN TasksDoneToday', () {
    group('WHEN pumped ', () {
      testWidgets(
        'THEN displays how many tasks are done today',
        (tester) async {
          await tester.pumpWithDependencies(const TasksDoneToday());

          expect(find.text('Wins today: 0'), findsOneWidget);
        },
      );

      // testWidgets(
      //   'THEN displays progress indicator',
      //   (tester) async {
      //     await tester.pumpWithDependencies(const TasksDoneToday());

      //     expect(find.byType(LinearProgressIndicator), findsOneWidget);
      //   },
      // );

      // testWidgets(
      //   'THEN displays daily streak',
      //   (tester) async {
      //     await tester.pumpWithDependencies(const TasksDoneToday());

      //     expect(find.text('Won days in a row: 0'), findsOneWidget);
      //   },
      // );
    });
  });
}

extension _PumpWithScaffold on WidgetTester {
  Future<void> pumpWithDependencies(Widget child) {
    return pumpWidget(
      BlocProvider(
        create: (context) => TasksDoneTodayCubit(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: child,
        ),
      ),
    );
  }
}
