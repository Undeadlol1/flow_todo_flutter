import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_history_fixture.dart';

void main() {
  group(
    'GIVEN Task',
    () {
      test(
        'WHEN toJson method is used '
        'THEN history property should be serialised properly',
        () {
          final result =
              taskFixture.copyWith(history: [taskHistoryFixture]).toJson();

          expect(result['history'], hasLength(1));
          expect(result['history'][0], isA<Map>());
          expect(result['history'][0]['actionType'], isA<String>());
        },
      );
    },
  );
}
