import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PositiveChoices extends StatelessWidget {
  final Task task;
  final _makeStepForward = GetIt.I<MakeStepForwardOnTheTask>();
  final _textPadding =
      const EdgeInsets.only(right: 20.0, left: 20, top: 20, bottom: 10);
  PositiveChoices({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: _textPadding,
          child: const Text(
            'If you spent at least 5 minutes working on a task, no matter the outcome, you may click "made step forward". Good job.',
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: _buildText('Made step forward'),
          onTap: () {
            _makeStepForward(
              task: task,
              howBigWasTheStep: Confidence.normal,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.emoji_emotions),
          title: _buildText('Advanced a lot'),
          onTap: () {
            _makeStepForward(
              task: task,
              howBigWasTheStep: Confidence.good,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.check),
          title: _buildText('Done'),
          onTap: () {
            _makeStepForward(
              task: task,
              isTaskDone: true,
              howBigWasTheStep: Confidence.good,
            );
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
