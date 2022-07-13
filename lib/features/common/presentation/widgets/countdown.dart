import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late final Timer timer;
  late final Stopwatch stopwatch;

  final _countdownDuration = const Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch()..start();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(() {}),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCountdownCompleted =
        stopwatch.elapsed.inMilliseconds > _countdownDuration.inMilliseconds;
    final timeToDisplay =
        (_countdownDuration.inMinutes - stopwatch.elapsed.inMinutes) - 1;
    final minutesRemaining = timeToDisplay - stopwatch.elapsed.inMinutes < 0
        ? 0
        : timeToDisplay - stopwatch.elapsed.inMinutes;
    final secondsRemaining =
        (_countdownDuration.inSeconds - stopwatch.elapsed.inSeconds) -
            (minutesRemaining * 60) -
            1;

    debugPrint('${stopwatch.elapsed}');

    if (isCountdownCompleted) {
      timer.cancel();
    }

    return FloatingActionButton(
      onPressed: null,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: isCountdownCompleted
            ? const Icon(Icons.check)
            : Text('$minutesRemaining:$secondsRemaining'),
      ),
    );
  }
}
