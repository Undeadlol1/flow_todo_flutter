import 'package:flutter/material.dart';

import '../../../common/presentation/page_layout.dart';
import '../../domain/models/task.dart';
import '../widgets/what_do_you_feel_about_the_task.dart';
import '../widgets/upsert_note.dart';

class TaskPageArguments {
  final Task task;
  final bool isNoteEditingVisible;
  TaskPageArguments({required this.task, this.isNoteEditingVisible = false});
}

class TaskPage extends StatelessWidget {
  static const pathName = '/task';
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)!.settings.arguments as TaskPageArguments);
    final task = args.task;

    return PageLayout(
      isAppBarHidden: false,
      isNumbersAnimationSuspended: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SelectableText(task.title),
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Additional info for developer:'),
                  const SizedBox(height: 10),
                  Text('isDone: ${task.isDone}'),
                  SelectableText('repetitionLevel: ${task.repetitionLevel}'),
                  Text(
                    'dueAt: ${DateTime.fromMillisecondsSinceEpoch(task.dueAt)}',
                  ),
                  SelectableText('id: ${task.id}'),
                  SelectableText('userId: ${task.userId}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
