import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context_provider/build_context_provider.dart';

import 'user_level_calculator.dart';
import '../../../users/presentation/cubit/profile_cubit.dart';

@injectable
class LevelUpAnimation {
  LevelUpAnimation({
    required this.userLevelCalculator,
    required this.buildContextProvider,
  });
  final UserLevelCalculator userLevelCalculator;
  final BuildContextProvider buildContextProvider;

  void show() {
    buildContextProvider(
      (context) {
        Timer(const Duration(seconds: 3), () => Navigator.of(context).pop());

        showGeneralDialog(
          context: context,
          barrierLabel: "Barrier",
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) {
            return Theme(
              data: Theme.of(context),
              child: Center(
                child: BlocSelector<ProfileCubit, ProfileState, int>(
                  selector: (state) => state.profile?.experience ?? 0,
                  builder: (_, experience) => Text(
                    'Level: ${userLevelCalculator(experience).value + 1}!',
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    );
  }
}
