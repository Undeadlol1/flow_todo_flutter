import 'package:flutter/material.dart';

class AnimatedFadeInOnVisibility extends StatefulWidget {
  final Widget child;
  const AnimatedFadeInOnVisibility({Key? key, required this.child})
      : super(key: key);

  @override
  State<AnimatedFadeInOnVisibility> createState() =>
      _AnimatedFadeInOnVisibilityState();
}

class _AnimatedFadeInOnVisibilityState
    extends State<AnimatedFadeInOnVisibility> {
  bool hasAnimationRan = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() => hasAnimationRan = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: hasAnimationRan ? widget.child : const SizedBox(),
    );
  }
}
