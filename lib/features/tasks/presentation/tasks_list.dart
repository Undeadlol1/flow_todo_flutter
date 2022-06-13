import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/presentation/widgets/pagination.dart';
import '../domain/models/task.dart';
import 'cubit/tasks_cubit.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Task> _localTasksList = [];
  final _animatedListKey = GlobalKey<AnimatedListState>();
  final _offsetAnimationTween = Tween<Offset>(
    begin: const Offset(0, 10),
    end: const Offset(0.0, 0),
  );

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        _localTasksList = BlocProvider.of<TasksCubit>(
          context,
          listen: false,
        ).state.tasks;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: _syncAnimatedListWithCubitsList,
      builder: (context, state) {
        debugPrint('state.tasks.length: ${state.tasks.length}');
        debugPrint('_localTasksList.length: ${_localTasksList.length}');
        return Column(
          children: [
            AnimatedList(
              shrinkWrap: true,
              key: _animatedListKey,
              initialItemCount: _localTasksList.length,
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
