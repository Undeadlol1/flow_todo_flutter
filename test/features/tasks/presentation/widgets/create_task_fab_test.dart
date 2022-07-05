import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_creation.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/create_task_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/mocks/mock_go_to_task_creation.dart';

final _mockGoToTaskCreation = MockGoToTaskCreation();

void main() {
  group('GIVEN CreateTaskFAB', () {
    testWidgets(
      "WHEN FAB is tapped "
      'THEN calls a use case',
      (WidgetTester tester) async {
        GetIt.I.registerSingleton<GoToTaskCreation>(_mockGoToTaskCreation);
        when(() => _mockGoToTaskCreation()).thenAnswer((invocation) {});

        await tester.pumpWithDependencies();
        await tester.tap(find.byType(CreateTaskFAB));
        await tester.pump();

        verify((() => _mockGoToTaskCreation())).called(1);
      },
    );
  });
}

extension on WidgetTester {
  Future<void> pumpWithDependencies() async {
    return pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CreateTaskFAB(),
      ),
    );
  }
}
