import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/positive_choices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utilities/fixtures/task_fixture.dart';

class _MockMakeStepForwardOnATask extends Mock
    implements MakeStepForwardOnTheTask {}

final _mockMakeStepForwardOnATask = _MockMakeStepForwardOnATask();

void main() {
  group('GIVEN PositiveChoices', () {
    setUpAll(() {
      GetIt.I.registerSingleton<MakeStepForwardOnTheTask>(
          _mockMakeStepForwardOnATask);
    });

    tearDownAll(GetIt.I.reset);

    testWidgets(
      'WHEN "step fordward" is tapped '
      'THEN calls use case properly',
      (WidgetTester tester) async {
        when(_useCaseCall(confidence: Confidence.normal))
            .thenAnswer((_) async {});

        await tester.pumpWithDependencies();
        await tester.tap(find.text('Made step forward'));

        verify(_useCaseCall(confidence: Confidence.normal)).called(1);
      },
    );

    testWidgets(
      'WHEN "advanced a lot" is tapped '
      'THEN calls use case properly',
      (WidgetTester tester) async {
        when(_useCaseCall(confidence: Confidence.good))
            .thenAnswer((_) async {});

        await tester.pumpWithDependencies();
        await tester.tap(find.text('Advanced a lot'));

        verify(_useCaseCall(confidence: Confidence.good)).called(1);
      },
    );

    testWidgets(
      'WHEN "done" is tapped '
      'THEN calls use case properly',
      (WidgetTester tester) async {
        when(_useCaseCall(confidence: Confidence.good, isTaskDone: true))
            .thenAnswer((_) async {});

        var buttonText = 'Done';
        await tester.pumpWithDependencies();
        await tester.tap(find.text(buttonText));

        verify(_useCaseCall(confidence: Confidence.good, isTaskDone: true))
            .called(1);
      },
    );
  });
}

_useCaseCall({required Confidence confidence, bool? isTaskDone}) =>
    () => _mockMakeStepForwardOnATask(
          task: taskFixture,
          howBigWasTheStep: confidence,
          isTaskDone: isTaskDone ?? false,
        );

extension on WidgetTester {
  Future<void> pumpWithDependencies() {
    return pumpWidget(
      // TODO do i need material app?
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: PositiveChoices(task: taskFixture),
          ),
        ),
      ),
    );
  }
}
