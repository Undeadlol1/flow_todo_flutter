import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ExperienceProgressBar extends StatefulWidget {
  const ExperienceProgressBar({Key? key}) : super(key: key);

  @override
  State<ExperienceProgressBar> createState() => _ExperienceIndicatorState();
}

class _ExperienceIndicatorState extends State<ExperienceProgressBar>
    with TickerProviderStateMixin {
  double precentage = 0.0;

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 10),
  //   vsync: this,
  // )..repeat();
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        precentage = Random().nextDouble() * 1.0;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Positioned(
        child: Container(
          width: double.infinity,
          // height: 15,
          height: 1500,
          padding: const EdgeInsets.only(bottom: 0),
          child: LiquidLinearProgressIndicator(
            value: precentage,
            borderRadius: 0,
            borderWidth: 0.0,
            borderColor: Colors.grey,
            direction: Axis.horizontal,
            center: Text("${(precentage * 100).floor().toInt()}%"),
          ),
        ),
      ),
    );
  }
}
