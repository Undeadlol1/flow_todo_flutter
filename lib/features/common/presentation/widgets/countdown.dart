import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late final Stopwatch stopwatch;
  late final Timer timer;

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
    const duration = Duration(minutes: 5);
    final timeToDisplay = duration.inSeconds - stopwatch.elapsed.inSeconds;

    if (stopwatch.elapsed.inMilliseconds > duration.inMilliseconds) {
      timer.cancel();
    }

    return FloatingActionButton(
      child: Text(timeToDisplay.toString()),
      onPressed: () {},
    );
  }
}
