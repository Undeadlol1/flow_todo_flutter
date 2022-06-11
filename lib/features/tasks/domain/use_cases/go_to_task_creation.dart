import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';

import '../../presentation/task_creation_modal.dart';

class GoToTaskCreation {
  final BuildContextProvider contextProvider;

  GoToTaskCreation({required this.contextProvider});

  void call() {
    contextProvider.call((context) {
      showModalBottomSheet(
        context: context,
        builder: (_) => const CreateTaskModal(),
      );
    });
  }
}
