import 'package:easy_debounce/easy_debounce.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:remove_emoji/remove_emoji.dart';

import '../../domain/models/task.dart';

class FilterTasksToDo extends StatefulWidget {
  const FilterTasksToDo({Key? key}) : super(key: key);

  @override
  State<FilterTasksToDo> createState() => _FilterTasksToDoState();
}

class _FilterTasksToDoState extends State<FilterTasksToDo> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocSelector<TasksToDoCubit, TasksToDoState, List<Task>>(
      selector: (state) => state.tasks,
      builder: (context, activeTasks) {
        return Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus == false) {
              _unfocusInputField();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 10,
            ),
            child: TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              toolbarOptions: const ToolbarOptions(
                cut: true,
                copy: true,
                paste: true,
                selectAll: true,
              ),
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Filter tasks',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: _inputController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _resetInput,
                        icon: const Icon(Icons.clear),
                      ),
              ),
              onEditingComplete: _unfocusInputField,
              onChanged: (text) {
                _debouceFuzzySearch(
                  text: text,
                  context: context,
                  activeTasks: activeTasks,
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _debouceFuzzySearch({
    required String text,
    required BuildContext context,
    required List<Task> activeTasks,
  }) {
    EasyDebounce.debounce(
      'filter_active_tasks',
      const Duration(milliseconds: 200),
      () {
        final input = _normalizeString(text);

        setState(() {});

        if (input.isEmpty) {
          _resetFilteredTasksList();
          return;
        }

        List<Task> filteredTasks = _getFilteredTasks(input, activeTasks);

        context.read<FilteredTasksCubit>().update(filteredTasks);
      },
    );
  }

  List<Task> _getFilteredTasks(String input, List<Task> activeTasks) {
    final List<Task> filteredTasks = [];

    for (final task in activeTasks) {
      final textToFilterBy = _normalizeString(task.title).removemoji;
      final similarityRatio = partialRatio(textToFilterBy, input);

      if (similarityRatio > 75) {
        filteredTasks.add(task);
      }
    }

    return filteredTasks;
  }

  void _resetInput() {
    _unfocusInputField();
    _inputController.clear();
    _resetFilteredTasksList();
    setState(() {});
  }

  void _unfocusInputField() => FocusManager.instance..primaryFocus?.unfocus();

  void _resetFilteredTasksList() =>
      context.read<FilteredTasksCubit>().update([]);

  String _normalizeString(String string) =>
      string.toLowerCase().replaceAll(' ', '');
}
