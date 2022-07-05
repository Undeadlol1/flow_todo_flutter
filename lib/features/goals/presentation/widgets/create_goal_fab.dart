import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../pages/goals_page.dart';

class CreateGoalFAB extends StatelessWidget {
  final SnackbarService snackbarService = GetIt.I();
  CreateGoalFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, GoalsPage.pathName);
        snackbarService.displaySnackbar(text: 'Redirecting to Goals Page');
      },
      child: const Icon(Icons.add),
    );
  }
}
