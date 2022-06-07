import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';

class MainPage extends StatefulWidget {
  static const pathName = '/main';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<AuthentificationCubit, AuthentificationState>(
              listener: (context, authState) async {
                // if (authState is Authenticated) {
                //   final tasks =
                //       await GetTasksToDo(firestore: GetIt.I()).call(userId: authState.user.id);
                //   _tasksCubit.update(tasks);
                // }
              },
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return const SignOutButton();
                }
                return const SizedBox(
                  height: 300,
                  child: SignInScreen(),
                );
              },
            ),
            const TasksList(),
          ],
        ),
        create: (context) => _tasksCubit,
      ),
    );
  }
}
