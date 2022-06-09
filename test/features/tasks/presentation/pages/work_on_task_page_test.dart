import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN WorkOnTaskPage', () {
    testWidgets(
      "SHOULD have PageLayoutAndDependencies",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(PageLayoutAndDependencies), findsOneWidget);
      },
    );
  });
}

Future<void> _pumpWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (_) => AuthentificationCubit(),
      child: const MaterialApp(
        home: WorkOnTaskPage(),
      ),
    ),
  );
}
