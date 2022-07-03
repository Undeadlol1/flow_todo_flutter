import 'package:flutter/material.dart';

import '../../../common/presentation/page_layout.dart';
import '../../domain/models/task.dart';
import '../widgets/upsert_task_form.dart';
import '../widgets/what_do_you_feel_about_the_task.dart';
import '../widgets/upsert_note.dart';

class TaskPageArguments {
  final Task task;
  final bool isNoteEditingVisible;
  final bool isTitleEditingVisible;
  TaskPageArguments({
    required this.task,
    this.isNoteEditingVisible = false,
    this.isTitleEditingVisible = false,
  });
}

class TaskPage extends StatelessWidget {
  static const pathName = '/task';
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TaskPageArguments;
    final task = args.task;

    return PageLayout(
      isAppBarHidden: false,
      isNumbersAnimationSuspended: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          if (!args.isTitleEditingVisible) SelectableText(task.title),
          if (args.isTitleEditingVisible) UpsertTaskForm(taskToUpdate: task),
          if (args.isNoteEditingVisible || task.note.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: UpsertNote(
                    task: task,
                    note: task.note,
                    autoFocus: args.isNoteEditingVisible,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          const WhatDoYouFeelAboutTheTask(),
        ],
      ),
    );
  }
}
