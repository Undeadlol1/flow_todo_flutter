import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../../../test_utilities/fakes/fake_user_level_calculator.dart';

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
  });

  group('GIVEN WorkOnTaskPage', () {
    testWidgets(
      "SHOULD have PageLayoutAndDependencies",
      (WidgetTester tester) async {
        await _pumpWidget(tester);

        expect(find.byType(PageLayout), findsOneWidget);
      },
    );
  });
}

Future<void> _pumpWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthentificationCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: const MaterialApp(
        home: WorkOnTaskPage(),
      ),
    ),
  );
}
