import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_build_context_provider.dart';
import '../../../../test_utilities/mocks/mock_stale_task_detector.dart';

class _MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  final buildContextProvider = MockBuildContextProvider();
  final MockStaleTaskDetector mockStaleTaskDetector = MockStaleTaskDetector();

  setUpAll(() {
    registerFallbackValue(taskFixture);

    when(() => mockStaleTaskDetector.isStale(any())).thenReturn(false);
  });

  group(
    'GIVEN GoToTaskPage '
    'WHEN called '
    'THEN',
    () {
      test(
        "redirects to task page",
        () {
          GoToTaskPage(
            provideContext: buildContextProvider,
            staleTaskDetector: mockStaleTaskDetector,
            firebaseAnalytics: _MockFirebaseAnalytics(),
          )(
            task: taskFixture,
          );

          expect(buildContextProvider.numberOfCalls, equals(1));
        },
      );
    },
  );
}
