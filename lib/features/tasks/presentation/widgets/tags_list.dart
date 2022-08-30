import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tags_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/tasks_cubit.dart';

class TagsList extends StatelessWidget {
  const TagsList({Key? key}) : super(key: key);
  static final _remoteConfig = GetIt.I<FirebaseRemoteConfig>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsCubit, TagsState>(
      builder: (context, tagsState) {
        return BlocBuilder<TasksCubit, TasksState>(
          buildWhen: _haveTagsChanged,
          builder: (context, tasksState) {
            if (_remoteConfig.getBool('are_tags_enabled')) {
              return Wrap(
                children: _getTags(tasksState)
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
                            BlocProvider.of<TagsCubit>(context, listen: false)
                                .update(tagsState.tags);
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
