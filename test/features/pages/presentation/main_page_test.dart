import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/pages/presentation/main_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_done_today.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../../test_utilities/fakes/fake_user_level_calculator.dart';

void main() {
  final tasksCuibit = TasksCubit();
  final authCubit = AuthentificationCubit();

  Future<void> _pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => authCubit),
          BlocProvider(create: (context) => tasksCuibit),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => TasksDoneTodayCubit()),
        ],
        child: const MaterialApp(
          home: MainPage(),
        ),
      ),
    );
  }

  group('GIVEN MainPage', () {
    setUpAll(() {
      GetIt.I.registerSingleton(authCubit);
      GetIt.I.registerSingleton(tasksCuibit);
      GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
    });

    tearDownAll(GetIt.I.reset);

    testWidgets(
      "SHOULD have PageLayoutAndDependencies",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(PageLayoutAndDependencies), findsOneWidget);
      },
    );

    testWidgets(
      "SHOULD display TasksList",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(TasksList), findsOneWidget);
      },
    );

    testWidgets(
      "SHOULD display TasksList",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(TasksDoneToday), findsOneWidget);
      },
    );
  });
}
