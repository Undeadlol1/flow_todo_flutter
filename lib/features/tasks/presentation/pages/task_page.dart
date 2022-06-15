import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/delete_task.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common/presentation/page_layout_and_dependencies.dart';
import '../../domain/models/task.dart';
import '../what_do_you_feel_about_the_task.dart';

class TaskPageArguments {
  final Task task;
  TaskPageArguments({required this.task});
}

class TaskPage extends StatelessWidget {
  static const pathName = '/task';
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task =
        (ModalRoute.of(context)!.settings.arguments as TaskPageArguments).task;

    return PageLayoutAndDependencies(
      child: Column(
        children: [
          Text(task.title),
          const SizedBox(height: 20),
          const WhatDoYouFeelAboutTheTask(),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => GetIt.I<DeleteTask>()(task),
          )
        ],
      ),
    );
  }
}
