import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/countdown.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/positive_choices.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/upsert_task_form.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/upsert_note.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fakes/fake_user_level_calculator.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_level_progress_percentage_calculator.dart';

final _binding = TestWidgetsFlutterBinding.ensureInitialized();

class _MockMakeStepForwardOnATask extends Mock
    implements MakeStepForwardOnTheTask {}

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<MakeStepForwardOnTheTask>(
      _MockMakeStepForwardOnATask(),
    );
  });

  group('GIVEN TaskPage', () {
    setUpAll(() {
      GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
      GetIt.I.registerSingleton<LevelProgressPercentageCalculator>(
        MockLevelProgressPercentageCalculator(),
      );
    });

    testWidgets(
      "SHOULD have PageLayoutAndDependencies",
      (WidgetTester tester) async {
        await tester.pumpWithDependencies();

        expect(find.byType(PageLayout), findsOneWidget);
      },
    );

    testWidgets(
      'SHOULD display task title',
      _pumpAndRunCallback(
        () => expect(find.text(taskFixture.title), findsOneWidget),
      ),
    );

    testWidgets(
      'SHOULD display task note',
      _pumpAndRunCallback(
        () => expect(find.text(taskFixture.note), findsOneWidget),
      ),
    );

    testWidgets(
      "SHOULD display task decisions",
      _pumpAndRunCallback(() {
        expect(find.byType(PositiveChoices), findsOneWidget);
      }),
    );

    testWidgets(
      "SHOULD task editing options",
      _pumpAndRunCallback(() {
        expect(
          find.byKey(const Key('edit menu')),
          findsOneWidget,
        );
      }),
    );

    testWidgets(
      'WHEN called without arguments '
      'THEN does not show extra widgets',
      (tester) async {
        await tester.pumpWithDependencies(task: taskFixture.copyWith(note: ''));

        expect(find.byType(UpsertNote), findsNothing);
        expect(find.byType(UpsertTaskForm), findsNothing);
      },
    );

    testWidgets(
      'SHOULD display task note',
      _pumpAndRunCallback(
        () => expect(
          find.byWidgetPredicate(
            (widget) => widget is UpsertNote && widget.note == taskFixture.note,
          ),
          findsOneWidget,
        ),
      ),
    );

    testWidgets(
      'SHOULD display task note',
      _pumpAndRunCallback(
        () => expect(find.byType(CountDown), findsOneWidget),
      ),
    );

    testWidgets(
      "WHEN title editing argument is provided "
      "SHOULD display title editing form",
      (tester) async {
        await tester.pumpWithDependencies(isTitleEditingVisible: true);

        expect(
          find.text(taskFixture.title),
          findsNWidgets(1),
          reason: 'Task title should not be visible when form is visible',
        );
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is UpsertTaskForm && widget.taskToUpdate == taskFixture,
          ),
          findsOneWidget,
        );
      },
    );
  });
}

Future<void> Function(WidgetTester tester) _pumpAndRunCallback(
  Function callback,
) {
  return (WidgetTester tester) async {
    await tester.pumpWithDependencies();

    callback();
  };
}

extension on WidgetTester {
  Future<void> pumpWithDependencies({
    Task? task,
    bool isTitleEditingVisible = false,
  }) async {
    await _binding.setSurfaceSize(const Size(700, 700));
    return pumpWidget(
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
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              settings: RouteSettings(
                arguments: TaskPageArguments(
                  task: task ?? taskFixture,
                  isTitleEditingVisible: isTitleEditingVisible,
                ),
              ),
              builder: (_) => const SizedBox(height: 1000, child: TaskPage()),
            );
          },
        ),
      ),
    );
  }
}
