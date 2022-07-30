import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/widgets/upsert_goal_form.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateGoalFAB extends StatelessWidget {
  final SnackbarService snackbarService = GetIt.I();
  CreateGoalFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => const UpsertGoalForm(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
