import 'package:flutter/widgets.dart';

class GoToTaskPage {
  // TODO fix this:
  final dynamic contextProvider;
  const GoToTaskPage({required this.contextProvider});

  void call() {
    contextProvider.provideBuildContext((context) {
      Navigator.pushNamed(context, '/task');
    });
  }
}
