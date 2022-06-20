import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flutter/material.dart';

class NegativeChoices extends StatelessWidget {
  final Task task;
  const NegativeChoices({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
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
