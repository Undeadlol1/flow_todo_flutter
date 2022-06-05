import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/widgets.dart';

class GoToTaskPage {
  // TODO fix this:
  final dynamic contextProvider;
  const GoToTaskPage({required this.contextProvider});

  void call() {
    BuildContextProvider.provideBuildContext((context) {
      Navigator.pushNamed(context, '/task');
    });
  }
}
