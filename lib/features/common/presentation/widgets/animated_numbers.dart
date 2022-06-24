import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedNumbers extends HookWidget {
  final int number;
  final Duration duration;
  const AnimatedNumbers({
    Key? key,
    required this.number,
    this.duration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final previousNumber = usePrevious(number);

    return Countup(
      duration: duration,
      end: number.toDouble(),
      begin: previousNumber?.toDouble() ?? 0,
    );
  }
}
