import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/positive_choices.dart';
import 'package:flutter/material.dart';

import '../../../common/presentation/page_layout.dart';
import '../../domain/models/task.dart';
import '../widgets/negative_choices.dart';
import '../widgets/upsert_task_form.dart';
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
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: IconButton(
              key: const Key('edit menu'),
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => NegativeChoices(task: task),
              ),
              icon: const Icon(Icons.more_vert),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              if (!args.isTitleEditingVisible)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SelectableText(task.title),
                  ),
                ),
              if (args.isTitleEditingVisible)
                UpsertTaskForm(taskToUpdate: task),
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
              PositiveChoices(task: task),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
