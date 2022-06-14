import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/positive_choices.dart';
import 'package:flutter/material.dart';

class WhatDoYouFeelAboutTheTask extends StatelessWidget {
  const WhatDoYouFeelAboutTheTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as TaskPageArguments;
              return PositiveChoices(task: args.task);
            },
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, WorkOnTaskPage.pathName);
          },
          icon: const Icon(Icons.thumb_down),
        ),
      ],
    );
  }
}
