import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/models/task.dart';
import '../../domain/use_cases/delete_task.dart';
import '../pages/task_page.dart';

class NegativeChoices extends StatelessWidget {
  final Task task;
  const NegativeChoices({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.delete),
          title: _buildText('Reject the task'),
          onTap: () => GetIt.I<DeleteTask>()(task),
        ),
        ListTile(
          leading: const Icon(Icons.note_add),
          title: _buildText('Add a note'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              TaskPage.pathName,
              arguments:
                  TaskPageArguments(task: task, isNoteEditingVisible: true),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(text, textAlign: TextAlign.center);
  }
}
