import 'package:flow_todo_flutter_2022/features/pages/presentation/main_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utilities/extensions/widget_tester_extensions.dart';

void main() {
  group('GIVEN MainPage', () {
    testWidgets(
      "SHOULD display TasksList",
      (WidgetTester tester) async {
        await tester.pumpWithDependencies(child: const MainPage());

        expect(find.byType(TasksList), findsOneWidget);
      },
    );
  });
}
