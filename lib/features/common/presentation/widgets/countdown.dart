import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late final Timer _timer;
  late final Stopwatch _stopwatch;

  final _countdownDuration = const Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCountdownCompleted =
        _stopwatch.elapsed.inMicroseconds > _countdownDuration.inMicroseconds;
    final remainingCountdown = Duration(
      microseconds: isCountdownCompleted
          ? 0
          : (_countdownDuration.inMicroseconds -
              _stopwatch.elapsedMicroseconds),
    );
    final String minutesAndSeconds =
        "${remainingCountdown.inMinutes.remainder(60)}"
        ":${(remainingCountdown.inSeconds.remainder(60))}";

    return FloatingActionButton(
      onPressed: null,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: isCountdownCompleted
            ? const Icon(Icons.check)
            : Text(minutesAndSeconds),
      ),
    );
  }
}
