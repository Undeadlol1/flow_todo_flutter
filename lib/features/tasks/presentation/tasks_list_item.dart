import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../domain/entities/task.dart';

class TasksListItem extends StatelessWidget {
  final Task task;
  const TasksListItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        GetIt.instance<GoToTaskPage>()(task: task);
      },
      child: Row(
        children: [
          Flexible(
            child: StaleTaskDetector().isTale(task) ? const Text('Stale') : Text(task.title),
          ),
        ],
      ),
    );
  }
}
