import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tags_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tasks_cubit.dart';

class TagsList extends StatelessWidget {
  const TagsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RemoteConfigCubit, RemoteConfigState, bool>(
      selector: (state) => state.areTagsEnabled,
      builder: (context, areTagsEnabled) {
        return BlocBuilder<TagsCubit, TagsState>(
          builder: (context, tagsState) {
            return BlocBuilder<TasksCubit, TasksState>(
              buildWhen: _haveTagsChanged,
              builder: (context, tasksState) {
                final tasks = tasksState.tasks;

                if (areTagsEnabled && tasks.length > 5) {
                  final tags = _getTags(tasksState);

                  if (tasks.any((task) => task.isStale)) {
                    tags
                      ..add('stale')
                      ..add('fresh');
                  }

                  return Wrap(
                    children: tags
                        .map(
                          (tag) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              selected: tagsState.tags.contains(tag),
                              // TODO extract into a use case
                              onSelected: (_) {
                                tagsState.tags.contains(tag)
                                    ? tagsState.tags.remove(tag)
                                    : tagsState.tags.add(tag);
                                BlocProvider.of<TagsCubit>(
                                  context,
                                  listen: false,
                                ).update(tagsState.tags);
                              },
                              label: Text(tag),
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          },
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
