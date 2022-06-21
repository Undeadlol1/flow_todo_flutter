import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/negative_choices.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/positive_choices.dart';
import 'package:flutter/material.dart';

class WhatDoYouFeelAboutTheTask extends StatelessWidget {
  const WhatDoYouFeelAboutTheTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task =
        (ModalRoute.of(context)!.settings.arguments as TaskPageArguments).task;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => PositiveChoices(task: task),
          ),
        ),
        IconButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => NegativeChoices(task: task),
          ),
          icon: const Icon(Icons.thumb_down),
        ),
      ],
    );
  }
}
