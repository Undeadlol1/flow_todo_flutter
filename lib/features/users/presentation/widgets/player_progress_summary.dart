import 'package:flutter/material.dart';

import '../../../tasks/presentation/widgets/tasks_done_today.dart';
import 'avatar.dart';

class PlayerProgressSummary extends StatelessWidget {
  const PlayerProgressSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 170),
      child: Card(
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Avatar(radius: 60),
            ),
            const Flexible(child: TasksDoneToday()),
          ],
        ),
      ),
    );
  }
}
