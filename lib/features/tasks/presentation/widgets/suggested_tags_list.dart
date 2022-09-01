import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/remote_config/cubit/remote_config_cubit.dart';
import '../cubit/tasks_cubit.dart';

class SuggestedTagsList extends StatefulWidget {
  final Function(String clickedTag) onChange;
  const SuggestedTagsList({Key? key, required this.onChange}) : super(key: key);

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
            final tasks = tasksState.tasks;

            if (areTagsEnabled && tasks.length > 5) {
              final tags = _getTagsUniquetags(tasksState);

              return Wrap(
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
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }

  Set<String> _getTagsUniquetags(TasksState tasksState) {
    final allTags = tasksState.tasks.map((e) => e.tags);
    final uniqueTags = allTags
        .expand((list) => list.map((e) => e))
        .map((e) => e.toLowerCase())
        .toSet();

    return uniqueTags;
  }

  bool _haveTagsChanged(previous, current) {
    return setEquals(_getTagsUniquetags(previous), _getTagsUniquetags(current));
  }
}
