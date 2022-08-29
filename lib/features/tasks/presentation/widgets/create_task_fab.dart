import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_creation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateTaskFAB extends StatelessWidget {
  const CreateTaskFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => GetIt.I<GoToTaskCreation>()(),
      child: const Icon(Icons.add),
    );
  }
}
