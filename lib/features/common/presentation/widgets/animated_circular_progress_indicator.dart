import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimatedCircularProgressIndicator extends StatefulWidget {
  final Widget child;
  final double radius;
  final double percent;
  final double lineWidth;
  const AnimatedCircularProgressIndicator({
    Key? key,
    required this.child,
    required this.radius,
    required this.percent,
    required this.lineWidth,
  }) : super(key: key);

  @override
  State<AnimatedCircularProgressIndicator> createState() =>
      _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState
    extends State<AnimatedCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  double _previousValueOfProgressCircle = 0;
  late Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(
      end: widget.percent,
      begin: 0,
    ).animate(_animationController);

    Future.microtask(() => _animationController.forward());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    _previousValueOfProgressCircle = oldWidget.percent;

    if (!_animationController.isAnimating) {
      _runAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, notAnimatedChild) {
        return CircularPercentIndicator(
          center: notAnimatedChild,
          percent: _animation.value,
          lineWidth: widget.lineWidth,
          radius: widget.radius + widget.lineWidth,
          progressColor: Theme.of(context).colorScheme.primary,
        );
      },
      child: Center(child: widget.child),
    );
  }

  void _runAnimation() {
    if (!mounted) return;

    _animation = Tween<double>(
      end: widget.percent,
      begin: _previousValueOfProgressCircle,
    ).animate(_animationController);

    _animationController
      ..reset()
      ..forward();
  }
}
