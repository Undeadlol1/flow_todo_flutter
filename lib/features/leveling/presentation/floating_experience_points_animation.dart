import 'dart:async';

import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
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

  bool _isTextVisible = false;
  static const _textRevealedDuration = Duration(seconds: 2);

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
        setState(() => _isTextVisible = true);
        Timer(
          _textRevealedDuration,
          () => setState(() => _isTextVisible = false),
        );
      },
      buildWhen: _buildWhenUserIsRewardedWithExp,
      listenWhen: _buildWhenUserIsRewardedWithExp,
      builder: (context, profileState) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _isTextVisible ? 1 : 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),

            child: AnimatedNumbers(
              duration: Duration(
                milliseconds: _textRevealedDuration.inMilliseconds - 500,
              ),
              number: profileState.profile?.experience ?? 0,
            ),
            // child: Text(
            //   profileState.profile?.experience.toString() ?? '0',
            // ),
          ),
        );
      },
    );
  }

  bool _buildWhenUserIsRewardedWithExp(previous, current) {
    return previous is ProfileLoaded && current is ProfileLoaded;
  }
}
