import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/toggle_task_selection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/use_cases/go_to_task_page.dart';

class TasksListItem extends StatelessWidget {
  final Task task;
  const TasksListItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => GetIt.I<GoToTaskPage>()(task: task),
      onLongPress: () => GetIt.I<ToggleTaskSelection>()(task),
      child: Row(
        children: [
          Flexible(
            child: Text(task.title),
          ),
        ],
      ),
    );
  }
}
