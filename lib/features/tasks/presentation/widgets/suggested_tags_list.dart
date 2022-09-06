import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/remote_config/cubit/remote_config_cubit.dart';
import '../cubit/tasks_cubit.dart';

class SuggestedTagsList extends StatefulWidget {
  final String title;
  final Function(String clickedTag) onChange;
  const SuggestedTagsList({
    Key? key,
    required this.onChange,
    required this.title,
  }) : super(key: key);

  @override
  State<SuggestedTagsList> createState() => _SuggestedTagsListState();
}

class _SuggestedTagsListState extends State<SuggestedTagsList> {
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RemoteConfigCubit, RemoteConfigState, bool>(
      selector: (state) => state.areTagsEnabled,
      builder: (context, areTagsEnabled) {
        return BlocBuilder<TasksCubit, TasksState>(
          buildWhen: _haveTagsChanged,
          builder: (context, tasksState) {
            final tags = _getTagsUniqueTags(tasksState);

            if (areTagsEnabled && tags.isNotEmpty) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Wrap(
                    children: tags
                        .map(
                          (tag) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(tag),
                              selected: selectedTags.contains(tag),
                              onSelected: (_) {
                                selectedTags.contains(tag)
                                    ? selectedTags.remove(tag)
                                    : selectedTags.add(tag);

                                widget.onChange(tag);

                                setState(() => selectedTags = selectedTags);
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }

  Set<String> _getTagsUniqueTags(TasksState tasksState) {
    final allTags = tasksState.tasks.map((e) => e.tags);
    final uniqueTags = allTags
        .expand((list) => list.map((e) => e))
        .map((e) => e.toLowerCase())
        .toList()
      ..sort();

    return uniqueTags.toSet();
  }

  bool _haveTagsChanged(TasksState previous, TasksState current) {
    return setEquals(_getTagsUniqueTags(previous), _getTagsUniqueTags(current));
  }
}
