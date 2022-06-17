import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';

import '../../common/presentation/widgets/pagination.dart';
import '../domain/models/task.dart';
import 'cubit/tasks_cubit.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> with TickerProviderStateMixin {
  List<Task> _localTasksList = GetIt.I<TasksCubit>().state.tasks;

  final _animatedListKey = GlobalKey<AnimatedListState>();
  final _offsetAnimationTween = Tween<Offset>(
    begin: const Offset(0, 10),
    end: const Offset(0.0, 0),
  );

  @override
  void initState() {
    Future.microtask(_ensureTasksAreTakenFromCubitWhenWidgetLoaded);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: _syncAnimatedListWithCubitsList,
      builder: (context, tasksState) {
        if (tasksState is TasksLoading) {
          return const _LoadingIndicator();
        }
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

  FutureOr<void> _ensureTasksAreTakenFromCubitWhenWidgetLoaded() {
    setState(() {
      _localTasksList = BlocProvider.of<TasksCubit>(context, listen: false).state.tasks;
    });
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 550,
        child: LoadingIndicator(
          size: 50,
          borderWidth: 1,
        ),
      ),
    );
  }
}
