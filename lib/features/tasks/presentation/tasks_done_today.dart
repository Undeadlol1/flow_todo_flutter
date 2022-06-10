import 'package:flutter/material.dart';

class TasksDoneToday extends StatelessWidget {
  const TasksDoneToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Wins today: 0'),
        LinearProgressIndicator(value: 1),
        Text('Won days in a row: 0'),
      ],
    );
  }
}