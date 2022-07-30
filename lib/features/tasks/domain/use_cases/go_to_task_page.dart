import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/pages/task_page.dart';

@injectable
class GoToTaskPage {
  final BuildContextProvider provideContext;
  const GoToTaskPage({required this.provideContext});

  void call({required Task task}) {
    provideContext((context) {
      Navigator.pushNamed(
        context,
        TaskPage.pathName,
        arguments: TaskPageArguments(task: task),
      );
    });
  }
}
