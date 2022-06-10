import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';

class GoToTaskCreation {
  final BuildContextProvider contextProvider;

  GoToTaskCreation({required this.contextProvider});

  void call() {
    contextProvider.call((context) {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return const _ModalBody();
        },
      );
    });
  }
}

// TODO extract this
class _ModalBody extends StatelessWidget {
  const _ModalBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: const <Widget>[
        SizedBox(height: 250, child: Center(child: Text('Hi there')))
      ],
    );
  }
}
