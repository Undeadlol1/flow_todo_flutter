import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_creation.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fakes/fake_user_level_calculator.dart';

class _MockGoToTaskCreation extends Mock implements GoToTaskCreation {}

final _mockGoToTaskCreation = _MockGoToTaskCreation();

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
  });

  group('GIVEN PageLayoutAndDependencies', () {
    testWidgets(
      'SHOULD display navigation bar',
      (tester) async {
        await _pumpWidget(tester: tester);

        expect(find.byType(AppBar), findsOneWidget);
      },
    );

    testWidgets(
      "SHOULD display back button if argument is provided",
      (WidgetTester tester) async {
        await _pumpWidget(tester: tester, isDrawerHidden: true);

        expect(
          find.byWidgetPredicate(
            (widget) => widget is Scaffold && widget.drawer == null,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "WHEN special argument "
      'THEN hides FAB',
      (WidgetTester tester) async {
        await _pumpWidget(tester: tester, isFABHidden: true);

        expect(find.byType(FloatingActionButton), findsNothing);
      },
    );

    testWidgets(
      "WHEN FAB is tapped "
      'THEN calls a use case',
      (WidgetTester tester) async {
        GetIt.I.registerSingleton<GoToTaskCreation>(_mockGoToTaskCreation);
        when(() => _mockGoToTaskCreation()).thenAnswer((invocation) {});

        await _pumpWidget(tester: tester, isDrawerHidden: true);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();

        verify((() => _mockGoToTaskCreation())).called(1);
      },
    );
  });
}

Future<void> _pumpWidget({
  required WidgetTester tester,
  bool isDrawerHidden = false,
  bool isFABHidden = false,
}) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthentificationCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: MaterialApp(
        home: PageLayoutAndDependencies(
          isFABHidden: isFABHidden,
          isDrawerHidden: isDrawerHidden,
          child: Container(),
        ),
      ),
    ),
  );
}
