import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/pagination.dart';
import 'package:get_it/get_it.dart';

import '../domain/models/task.dart';
import 'tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/tasks_cubit.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final _animatedListKey = GlobalKey<AnimatedListState>();
  List<Task> _localTasksList = GetIt.I<TasksCubit>().state.tasks;
  final _offsetAnimationTween = Tween<Offset>(
    begin: const Offset(0, 10),
    end: const Offset(0.0, 0),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: _syncAnimatedListWithCubitsList,
      builder: (context, state) {
        return Column(
          children: [
            AnimatedList(
              shrinkWrap: true,
              key: _animatedListKey,
              initialItemCount: state.tasks.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index, animation) {
                return SlideTransition(
                  position: animation.drive(_offsetAnimationTween),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TasksListItem(task: _localTasksList[index]),
                  ),
                );
              },
            ),
            Center(
              child: Text('Length: ${state.tasks.length}'),
            ),
            Pagination(
              onPageChange: (newPageNumber) {},
            ),
          ],
        );
      },
    );
  }

  void _syncAnimatedListWithCubitsList(_, TasksState tasksState) {
    final animatedList = _animatedListKey.currentState;

    for (final task in tasksState.tasks) {
      if (!_localTasksList.contains(task)) {
        final taskIndex = tasksState.tasks.indexOf(task);

        _localTasksList.insert(taskIndex, task);
        animatedList?.insertItem(taskIndex);
      }
    }

    for (final task in _localTasksList) {
      if (!tasksState.tasks.contains(task)) {
        final taskIndex = _localTasksList.indexOf(task);

        _localTasksList.remove(task);
        animatedList?.removeItem(taskIndex, (_, __) => Container());
      }

      setState(() => _localTasksList = _localTasksList);
    }
  }
}
