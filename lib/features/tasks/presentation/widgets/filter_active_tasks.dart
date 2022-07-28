import 'package:easy_debounce/easy_debounce.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:remove_emoji/remove_emoji.dart';

import '../../domain/models/task.dart';

// NOTE: https://github.com/SphericalKat/dart-fuzzywuzzy/issues/6#issuecomment-1177672619
final _removeEmoji = RemoveEmoji().removemoji;

class FilterActiveTasks extends StatefulWidget {
  const FilterActiveTasks({Key? key}) : super(key: key);

  @override
  State<FilterActiveTasks> createState() => _FilterActiveTasksState();
}

class _FilterActiveTasksState extends State<FilterActiveTasks> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final activeTasks = context.watch<TasksCubit>().state.tasks;

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
              toolbarOptions: const ToolbarOptions(
                cut: true,
                copy: true,
                paste: true,
                selectAll: true,
              ),
              controller: _inputController,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'Filter tasks',
                suffixIcon: _inputController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _inputController.clear();
                          _resetFilteredTasksList();
                        },
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
      const Duration(milliseconds: 500),
      () {
        setState(() {});

        if (text.trim().isEmpty) {
          _resetFilteredTasksList();
          return;
        }

        final taskTitles =
            activeTasks.map((e) => e.title).map(_removeEmoji).toList();
        final List<Task> matchedTitles = extractTop(
          limit: 3,
          cutoff: 65,
          query: text,
          choices: taskTitles,
        )
            .map(
              (match) => activeTasks.firstWhere(
                (task) => task.title.trim() == match.choice.trim(),
              ),
            )
            .toList();

        context.read<FilteredTasksCubit>().update(matchedTitles);
      },
    );
  }

  void _unfocusInputField() => FocusManager.instance..primaryFocus?.unfocus();

  void _resetFilteredTasksList() {
    context.read<FilteredTasksCubit>().update([]);
  }
}
