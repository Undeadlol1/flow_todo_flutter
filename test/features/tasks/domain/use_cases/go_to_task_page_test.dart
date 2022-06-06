import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utilities/mocks/mock_build_context_provider.dart';

void main() {
  final buildContextProvider = MockBuildContextProvider();

  tearDown(buildContextProvider.reset);

  group(
    'GIVEN GoToTaskPage '
    'WHEN called '
    'THEN',
    () {
      test(
        "redirects to task page",
        () {
          GoToTaskPage(contextProvider: buildContextProvider)();

          expect(buildContextProvider.numberOfCalls, equals(1));
        },
      );

      // test(
      //   "updates active task state",
      //   () {
      //               GoToTaskPage()();
      //   },
      // );
    },
  );
}
