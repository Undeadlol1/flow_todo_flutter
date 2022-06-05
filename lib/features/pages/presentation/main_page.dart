import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _tasksCubit = TasksCubit();

  final _taskFixture = Task(
    id: 'id',
    title: 'title',
    dueAt: 0,
    isDone: false,
    userId: 'userId',
    createdAt: 0,
  );

  @override
  void initState() {
    super.initState();
    _tasksCubit.update([_taskFixture, _taskFixture]);
  }

  @override
  Widget build(BuildContext context) {
    return PageLayoutAndDependencies(
      child: BlocProvider(
        child: const TasksList(),
        create: (context) => _tasksCubit,
      ),
    );
  }
}
