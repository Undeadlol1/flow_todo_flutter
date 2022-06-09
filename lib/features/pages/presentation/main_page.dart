import 'package:flow_todo_flutter_2022/features/common/presentation/page_layout_and_dependencies.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/tasks_list.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static const pathName = '/main';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayoutAndDependencies(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TasksList(),
        ],
      ),
    );
  }
}
