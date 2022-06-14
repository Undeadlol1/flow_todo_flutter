import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/widgets.dart';

import '../../presentation/pages/task_page.dart';

class GoToTaskPage {
  final BuildContextProvider contextProvider;
  const GoToTaskPage({required this.contextProvider});

  void call({required Task task}) {
    contextProvider.call((BuildContext cx) {
      Navigator.pushNamed(
        cx,
        '/task',
        arguments: TaskPageArguments(task: task),
      );
    });
  }
}
