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
  int _expDifference = 0;
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
        _setTextVisibility(true);

        _hideTextTimer =
            Timer(_textRevealedDuration, () => _setTextVisibility(false));
      },
      buildWhen: _isExperienceAmountChanged,
      listenWhen: _isExperienceAmountChanged,
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
            child: Text('+$_expDifference'),
          ),
        );
      },
    );
  }

  void _setTextVisibility(bool isVisible) =>
      setState(() => _isTextVisible = isVisible);

  bool _isExperienceAmountChanged(previous, current) {
    if (previous is! ProfileLoaded || current is! ProfileLoaded) {
      return false;
    }

    final expDifference =
        current.profile.experience - previous.profile.experience;

    setState(() => _expDifference = expDifference);

    return expDifference > 0;
  }
}
