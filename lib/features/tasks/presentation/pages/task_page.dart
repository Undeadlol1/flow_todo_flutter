import 'package:flutter/material.dart';

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
    final args =
        ModalRoute.of(context)!.settings.arguments as TaskPageArguments;

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
