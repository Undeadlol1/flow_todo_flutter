import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flutter/material.dart';

class CreateGoalFAB extends StatelessWidget {
  final SnackbarService snackbarService;
  const CreateGoalFAB({Key? key, required this.snackbarService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        snackbarService.displaySnackbar(text: 'Not yet implemented');
      },
      child: const Icon(Icons.add),
    );
  }
}
