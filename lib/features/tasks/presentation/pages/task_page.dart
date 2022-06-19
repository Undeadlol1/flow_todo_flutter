import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common/presentation/page_layout_and_dependencies.dart';
import '../../domain/models/task.dart';
import '../../domain/use_cases/delete_task.dart';
import '../what_do_you_feel_about_the_task.dart';
import '../widgets/upsert_note.dart';

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
          const SizedBox(height: 20),
          SelectableText(task.title),
          if (task.note.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: UpsertNote(
                    note: task.note,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          const WhatDoYouFeelAboutTheTask(),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => GetIt.I<DeleteTask>()(task),
          ),
        ],
      ),
    );
  }
}
