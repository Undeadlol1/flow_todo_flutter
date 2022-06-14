import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PositiveChoices extends StatelessWidget {
  final Task task;
  const PositiveChoices({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final makeStepForward = GetIt.I<MakeStepForwardOnTheTask>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.favorite),
          title: _buildText('Made step forward'),
          onTap: () {
            makeStepForward(
              task: task,
              howBigWasTheStep: Confidence.normal,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.emoji_emotions),
          title: _buildText('Advanced a lot'),
          onTap: () {
            makeStepForward(
              task: task,
              howBigWasTheStep: Confidence.good,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.check),
          title: _buildText('Done'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(text, textAlign: TextAlign.center);
  }
}
