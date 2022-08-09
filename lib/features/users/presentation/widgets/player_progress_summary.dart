import 'package:flutter/material.dart';

import '../../../quests/presentation/widgets/active_quest.dart';
import '../../../tasks/presentation/widgets/tasks_worked_on_today.dart';
import 'avatar.dart';

class PlayerProgressSummary extends StatelessWidget {
  const PlayerProgressSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const contraints = BoxConstraints.tightForFinite(width: 220);
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Avatar(radius: 60),
          ),
          Column(
            children: [
              ConstrainedBox(
                constraints: contraints,
                child: const ActiveQuest(),
              ),
              ConstrainedBox(
                constraints: contraints,
                child: const TasksWorkedOnToday(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
