import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/pages/presentation/main_page.dart';

void main() {
  setUpDI() {
    GetIt.I.registerSingleton(BuildContextProvider());
    GetIt.I.registerSingleton(GoToTaskPage(contextProvider: GetIt.I));
  }

  setUpDI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var taskFixture = Task(
      id: 'id',
      title: 'title',
      dueAt: 0,
      isDone: false,
      userId: 'userId',
      createdAt: 0,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: '/main',
      routes: {
        '/main': (contex) => const Scaffold(body: MainPage()),
        '/task': (contex) => TaskPage(task: taskFixture),
      },
    );
  }
}
