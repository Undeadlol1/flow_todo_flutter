import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/use_cases/reset_experience.dart';

class ResetExpereinceButton extends StatelessWidget {
  const ResetExpereinceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Reset experience?'),
              content: const Text(
                'This will reset your level to 1. This can not be undone. Are you sure?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    GetIt.I<ResetExperience>()();
                    Navigator.pop(context);
                  },
                  child: const Text('RESET'),
                ),
              ],
            );
          },
        )
      },
      child: const Text('Reset Experience'),
    );
  }
}
