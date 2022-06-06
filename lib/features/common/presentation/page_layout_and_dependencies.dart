import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';

class PageLayoutAndDependencies extends StatelessWidget {
  final Widget child;
  const PageLayoutAndDependencies({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            child,
            const ListenerThatRunsFunctionsWithBuildContext(),
          ],
        ),
      ),
    );
  }
}
