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
  // TODO rename
  List<Task> _localList = GetIt.I<TasksCubit>().state.tasks;

  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (_, tasksState) {
        final animatedList = _animatedListKey.currentState;

        for (final task in tasksState.tasks) {
          if (!_localList.contains(task)) {
            debugPrint('FALSE');
            // TODO refactor
            final indexOf = tasksState.tasks.indexOf(task);
            _localList.insert(indexOf, task);
            animatedList?.insertItem(indexOf);
          }
        }

        for (final task in _localList) {
          if (!tasksState.tasks.contains(task)) {
            debugPrint('FALSE');
            // TODO refactor
            final indexOf = _localList.indexOf(task);
            _localList.remove(task);
            animatedList?.removeItem(indexOf, (_, __) => Container());
          }

          setState(() => _localList = _localList);
        }
      },
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
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(0, 10),
                      end: const Offset(0.0, 0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TasksListItem(task: _localList[index]),
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
}
