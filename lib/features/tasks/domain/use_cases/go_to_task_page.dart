import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/widgets.dart';

class GoToTaskPage {
  final BuildContextProvider contextProvider;
  const GoToTaskPage({required this.contextProvider});

  void call() {
    contextProvider.call((BuildContext cx) {
      Navigator.pushNamed(cx, '/task');
    });
  }
}
