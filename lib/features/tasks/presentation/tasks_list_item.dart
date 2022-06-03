import 'package:flutter/material.dart';

import '../domain/task.dart';

class TasksListItem extends StatelessWidget {
  final Task task;
  const TasksListItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(task.title),
      ],
    );
  }
}
