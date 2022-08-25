import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flutter/material.dart';

import '../../../common/presentation/page_layout.dart';
import '../../../common/presentation/widgets/countdown.dart';
import '../../domain/models/task.dart';
import '../widgets/negative_choices.dart';
import '../widgets/positive_choices.dart';
import '../widgets/upsert_task_form.dart';
import '../widgets/edit_note_form.dart';

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
      floatingActionButton: const CountDown(),
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
          args.isNoteEditingVisible || task.note.isNotEmpty
              ? SingleChildScrollView(
                  child: _PageBody(pageArguments: args, task: task),
                )
              : _PageBody(pageArguments: args, task: task)
        ],
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody({
    Key? key,
    required this.task,
    required this.pageArguments,
  }) : super(key: key);

  final TaskPageArguments pageArguments;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        if (!pageArguments.isTitleEditingVisible)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SelectableText(task.title),
            ),
          ),
        if (pageArguments.isTitleEditingVisible)
          UpsertTaskForm(taskToUpdate: task),
        if (pageArguments.isNoteEditingVisible || task.note.isNotEmpty)
          EditNoteForm(
            task: task,
            note: task.note,
            autoFocus: pageArguments.isNoteEditingVisible,
          ),
        const SizedBox(height: 20),
        CardView(
          child: PositiveChoices(task: task),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
