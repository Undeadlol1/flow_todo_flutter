import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ExperienceProgressBar extends StatelessWidget {
  final double percentage;
  const ExperienceProgressBar({Key? key, required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Positioned(
        child: Container(
          width: double.infinity,
          height: 15,
          // height: 1500,
          padding: const EdgeInsets.only(bottom: 0),
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 700),
            tween: Tween<double>(begin: 0, end: percentage),
            builder: (BuildContext context, double value, Widget? child) {
              return LiquidLinearProgressIndicator(
                value: value,
                borderRadius: 0,
                borderWidth: 0.0,
                borderColor: Colors.grey,
                direction: Axis.horizontal,
                center: Text("${(percentage * 100).floor().toInt()}%"),
              );
            },
          ),
        ),
      ),
    );
  }
}
