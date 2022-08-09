import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'tasks_list_item.dart';

class SelectedTasks extends StatelessWidget {
  const SelectedTasks({Key? key}) : super(key: key);

  @override
  build(context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, tasksState) {
        final tasks = tasksState.tasks.where((i) => i.isSelected).toList();

        if (tasks.isEmpty) {
          return const SizedBox();
        }

        return CardView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Selected tasks:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Divider(thickness: 0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => TasksListItem(task: tasks[index]),
              ),
            ],
          ),
        );
      },
    );
  }
}
