import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/what_do_you_feel_about_the_task.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';

class TaskPageArguments {
  final Task task;
  TaskPageArguments({required this.task});
}

class TaskPage extends StatelessWidget {
  static const pathName = '/task';
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TaskPageArguments;

    return PageLayoutAndDependencies(
      child: Column(
        children: [
          Text(args.task.title),
          const SizedBox(height: 20),
          const WhatDoYouFeelAboutTheTask(),
        ],
      ),
    );
  }
}
