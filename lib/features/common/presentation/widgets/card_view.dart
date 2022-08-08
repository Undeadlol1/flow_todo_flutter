import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final Widget child;
  const CardView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
