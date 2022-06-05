import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN PageLayoutAndDependencies', () {
    testWidgets(
      'SHOULD display navigation bar',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: PageLayoutAndDependencies(
              child: Container(),
            ),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
      },
    );
  });
}
