import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedNumbers extends HookWidget {
  final int number;
  const AnimatedNumbers({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final previousNumber = usePrevious(number);

    return Countup(
      end: number.toDouble(),
      begin: previousNumber?.toDouble() ?? 0,
      duration: const Duration(seconds: 3),
    );
  }
}
