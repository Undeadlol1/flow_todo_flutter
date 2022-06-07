import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/pages/presentation/main_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN MainPage', () {
    // testWidgets(
    //   "SHOULD have PageLayoutAndDependencies",
    //   (WidgetTester tester) async {
    //     await _pumpWidget(tester);

    //     expect(find.byType(PageLayoutAndDependencies), findsOneWidget);
    //   },
    // );

    // testWidgets(
    //   "SHOULD display TasksList",
    //   (WidgetTester tester) async {
    //     await _pumpWidget(tester);

    //     expect(find.byType(TasksList), findsOneWidget);
    //   },
    // );
  });
}

Future<void> _pumpWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (context) => AuthentificationCubit(),
      child: const MaterialApp(
        home: SizedBox(
          child: MainPage(),
        ),
      ),
    ),
  );
}
