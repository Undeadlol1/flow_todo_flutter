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
        await tester.pumpWidget(
          BlocProvider(
            create: (_) => AuthentificationCubit(),
            child: MaterialApp(
              home: PageLayoutAndDependencies(
                child: Container(),
              ),
            ),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
      },
    );
  });
}
