import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/what_do_you_feel_about_the_task.dart';
import 'package:flutter/material.dart';

import '../../domain/task.dart';

class TaskPage extends StatelessWidget {
  final Task task;
  const TaskPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayoutAndDependencies(
      child: Column(
        children: [
          Text(task.title),
          const WhatDoYouFeelAboutTheTask(),
        ],
      ),
    );
  }
}
