import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:remove_emoji/remove_emoji.dart';

// NOTE: https://github.com/SphericalKat/dart-fuzzywuzzy/issues/6#issuecomment-1177672619
final _removeEmoji = RemoveEmoji().removemoji;

class FilterActiveTasks extends StatelessWidget {
  const FilterActiveTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final activeTasks = context.watch<TasksCubit>().state.tasks;
        final taskTitles =
            activeTasks.map((e) => e.title).map(_removeEmoji).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 10,
          ),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Filter tasks'),
            onChanged: (text) {
              _debouceFuzzySearch(text: text, choices: taskTitles);
            },
          ),
        );
      },
    );
  }

  void _debouceFuzzySearch({
    required String text,
    required List<String> choices,
  }) {
    EasyDebounce.debounce(
      'filter_active_tasks',
      const Duration(milliseconds: 500),
      () {
        log('-------');
        extractTop(
          query: text,
          choices: choices,
          limit: 3,
          cutoff: 65,
        ).forEach((element) {
          log(element.choice);
          log(element.score.toString());
        });
      },
    );
  }
}
