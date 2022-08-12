import 'dart:async';

import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
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

  Future<void> show() {
    buildContextProvider(
      (context) {
        final theme = Theme.of(context);
        showGeneralDialog(
          context: context,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.8),
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) {
            return Center(
              child: BlocSelector<ProfileCubit, ProfileState, int>(
                selector: (state) => state.profile?.experience ?? 0,
                builder: (_, experience) => CardView(
                  child: Text(
                    'Level ${userLevelCalculator(experience).value}!',
                    style: theme.textTheme.headline2,
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

    return Future.delayed(
      const Duration(seconds: 3),
      () => buildContextProvider(Navigator.pop),
    );
  }
}
