import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/static_tags_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../common/presentation/page_layout.dart';
import '../../../common/presentation/widgets/countdown.dart';
import '../../domain/models/task.dart';
import '../cubit/filtered_tasks_cubit.dart';
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
  static final _filteredTasksCubit = GetIt.I<FilteredTasksCubit>();
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TaskPageArguments;
    final task = args.task;

    return BlocProvider(
      create: (_) => _filteredTasksCubit,
      child: PageLayout(
        isAppBarHidden: false,
        isNumbersAnimationSuspended: true,
        floatingActionButton: const CountDown(),
        child: Stack(
          children: [
            args.isNoteEditingVisible || task.note.isNotEmpty
                ? const SingleChildScrollView(child: _PageBody())
                : const _PageBody(),
            Positioned(
              right: 0,
              child: IconButton(
                key: const Key('edit menu'),
                icon: const Icon(Icons.more_vert),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => NegativeChoices(task: task),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageArguments =
        ModalRoute.of(context)!.settings.arguments as TaskPageArguments;
    final task = pageArguments.task;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: pageArguments.isTitleEditingVisible
              ? UpsertTaskForm(taskToUpdate: task)
              : Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SelectableText(task.title),
                  ),
                ),
        ),
        if (task.tags.isNotEmpty) _Tags(task: task),
        if (pageArguments.isNoteEditingVisible || task.note.isNotEmpty)
          EditNoteForm(
            task: task,
            note: task.note,
            autoFocus: pageArguments.isNoteEditingVisible,
          ),
        if (task.isStale)
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: _StaleTaskExplanation(),
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

class _Tags extends StatelessWidget {
  const _Tags({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: StaticTagsList(tags: task.tags),
    );
  }
}

class _StaleTaskExplanation extends StatelessWidget {
  const _StaleTaskExplanation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Text(
        '💩 '
        'Your task is stale. Its title is going to be hidden from tasks list in order to prompt you to come back to it more often.',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}
