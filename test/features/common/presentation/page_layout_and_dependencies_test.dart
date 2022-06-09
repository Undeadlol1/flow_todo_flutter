import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
            findsOneWidget);
      },
    );
  });
}

Future<void> _pumpWidget(
    {required WidgetTester tester, bool isDrawerHidden = false}) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (_) => AuthentificationCubit(),
      child: MaterialApp(
        home: PageLayoutAndDependencies(
          isDrawerHidden: isDrawerHidden,
          child: Container(),
        ),
      ),
    ),
  );
}
