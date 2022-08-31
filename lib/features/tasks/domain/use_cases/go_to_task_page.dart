import 'package:build_context_provider/build_context_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/pages/task_page.dart';

@injectable
class GoToTaskPage {
  final BuildContextProvider provideContext;
  final StaleTaskDetector staleTaskDetector;
  final FirebaseAnalytics firebaseAnalytics;
  const GoToTaskPage({
    required this.provideContext,
    required this.staleTaskDetector,
    required this.firebaseAnalytics,
  });

  void call({required Task task}) {
    provideContext((context) {
      Navigator.pushNamed(
        context,
        TaskPage.pathName,
        arguments: TaskPageArguments(task: task),
      );
    });

    if (staleTaskDetector.isStale(task)) {
      firebaseAnalytics.logEvent(name: 'navigate_to_stale_task');
    }
  }
}
