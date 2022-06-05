import 'package:flow_todo_flutter_2022/features/pages/presentation/main_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

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

extension on WidgetTester {
  Future<void> pumpWithDependencies({
    required Widget child,
  }) {
    // ignore: unnecessary_this
    return this.pumpWidget(
      BlocProvider<TasksCubit>(
        create: (context) => TasksCubit(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: child,
        ),
      ),
    );
  }
}
