import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/positive_choices.dart';
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
        _mockMakeStepForwardOnATask,
      );
    });

    tearDownAll(GetIt.I.reset);

    testWidgets(
      'WHEN "step fordward" is tapped '
      'THEN calls use case properly',
      _verifyUseCaseCallOnTap(
        buttonText: 'Made step forward',
        confidenceToVerify: Confidence.normal,
      ),
    );

    testWidgets(
      'WHEN "advanced a lot" is tapped '
      'THEN calls use case properly',
      _verifyUseCaseCallOnTap(
        buttonText: 'Advanced a lot',
        confidenceToVerify: Confidence.good,
      ),
    );

    testWidgets(
      'WHEN "done" is tapped '
      'THEN calls use case properly',
      _verifyUseCaseCallOnTap(
        buttonText: 'Done',
        shouldTaskBeMarkedAsDone: true,
        confidenceToVerify: Confidence.good,
      ),
    );
  });
}

_useCaseCall({required Confidence confidence, bool? isTaskDone}) =>
    () => _mockMakeStepForwardOnATask(
          task: taskFixture,
          howBigWasTheStep: confidence,
          isTaskDone: isTaskDone ?? false,
        );

_verifyUseCaseCallOnTap({
  bool shouldTaskBeMarkedAsDone = false,
  required String buttonText,
  required Confidence confidenceToVerify,
}) {
  return (WidgetTester tester) async {
    when(
      _useCaseCall(
        confidence: confidenceToVerify,
        isTaskDone: shouldTaskBeMarkedAsDone,
      ),
    ).thenAnswer((_) async {});

    await tester.pumpWithDependencies();
    await tester.tap(find.text(buttonText));

    verify(
      _useCaseCall(
        confidence: confidenceToVerify,
        isTaskDone: shouldTaskBeMarkedAsDone,
      ),
    ).called(1);
  };
}

extension on WidgetTester {
  Future<void> pumpWithDependencies() {
    return pumpWidget(
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
