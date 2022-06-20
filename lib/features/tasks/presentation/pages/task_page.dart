import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common/presentation/page_layout_and_dependencies.dart';
import '../../domain/models/task.dart';
import '../../domain/use_cases/delete_task.dart';
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

    return PageLayoutAndDependencies(
      child: Column(
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
                    autoFocus: args.isNoteEditingVisible,
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
