import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../../test_utilities/fakes/fake_user_level_calculator.dart';
import '../../../test_utilities/mocks/mock_hydrated_storage.dart';
import '../../../test_utilities/mocks/mock_level_progress_percentage_calculator.dart';

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<UserLevelCalculator>(FakeUserLevelCalculator());
    GetIt.I.registerSingleton<LevelProgressPercentageCalculator>(
      MockLevelProgressPercentageCalculator(),
    );
  });

  group('GIVEN PageLayout', () {
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
          findsOneWidget,
        );
      },
    );
  });
}

Future<void> _pumpWidget({
  required WidgetTester tester,
  bool isDrawerHidden = false,
}) async {
  await mockHydratedStorage(() async {
    return await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthentificationCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(),
          ),
        ],
        child: MaterialApp(
          home: PageLayout(
            child: Container(),
          ),
        ),
      ),
    );
  });
}
