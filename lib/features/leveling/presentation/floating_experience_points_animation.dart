import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../users/presentation/cubit/profile_cubit.dart';

class FloatingExperiencePointsAnimation extends StatefulWidget {
  const FloatingExperiencePointsAnimation({Key? key}) : super(key: key);

  @override
  State<FloatingExperiencePointsAnimation> createState() =>
      _FloatingExperiencePointsAnimationState();
}

class _FloatingExperiencePointsAnimationState
    extends State<FloatingExperiencePointsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isTextVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        setState(() => isTextVisible = true);
        Timer(
          const Duration(seconds: 1),
          () => setState(() => isTextVisible = false),
        );
      },
      buildWhen: _buildWhenUserIsRewardedWithExp,
      listenWhen: _buildWhenUserIsRewardedWithExp,
      builder: (context, profileState) {
        return Visibility(
          visible: isTextVisible,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              profileState.profile?.experience.toString() ?? '0',
            ),
          ),
        );
      },
    );
  }

  bool _buildWhenUserIsRewardedWithExp(previous, current) {
    return previous is ProfileLoaded && current is ProfileLoaded;
  }
}
