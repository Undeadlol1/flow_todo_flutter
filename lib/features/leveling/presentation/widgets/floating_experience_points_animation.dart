import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';

class FloatingExperiencePointsAnimation extends StatefulWidget {
  const FloatingExperiencePointsAnimation({Key? key}) : super(key: key);

  @override
  State<FloatingExperiencePointsAnimation> createState() =>
      _FloatingExperiencePointsAnimationState();
}

class _FloatingExperiencePointsAnimationState
    extends State<FloatingExperiencePointsAnimation> {
  Timer? _hideTextTimer;
  bool _isTextVisible = false;
  int _expPointsToDisplay = 0;
  static const _textRevealedDuration = Duration(seconds: 2);

  @override
  void dispose() {
    _hideTextTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        setState(() => _isTextVisible = true);
        _hideTextTimer = Timer(
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
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Text('+$_expPointsToDisplay'),
          ),
        );
      },
    );
  }

  bool _buildWhenUserIsRewardedWithExp(previous, current) {
    if (previous is ProfileLoaded && current is ProfileLoaded) {
      final expDifference = _expPointsToDisplay =
          (current.profile?.experience ?? 0) -
              (previous.profile?.experience ?? 0);

      _expPointsToDisplay = expDifference;

      return expDifference <= 0;
    }
    return false;
  }
}
