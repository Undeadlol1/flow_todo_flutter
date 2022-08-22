import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tasks_cubit.dart';

class TagsList extends StatelessWidget {
  const TagsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      buildWhen: _haveTagsChanged,
      builder: (context, tasksState) {
        return Wrap(
          children: _getTags(tasksState)
              .map(
                (tag) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Chip(
                    label: Text(tag),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Set<String> _getTags(TasksState tasksState) {
    final allTags = tasksState.tasks.map((e) => e.tags);
    final uniqueTags = allTags
        .expand((list) => list.map((e) => e))
        .map((e) => e.toLowerCase())
        .toSet();

    return uniqueTags;
  }

  bool _haveTagsChanged(previous, current) {
    return setEquals(_getTags(previous), _getTags(current));
  }
}
