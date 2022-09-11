import 'dart:async';

import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ExperienceProgressBar extends StatefulWidget {
  final ThemeData themeData;
  const ExperienceProgressBar({Key? key, required this.themeData})
      : super(key: key);

  @override
  State<ExperienceProgressBar> createState() => _ExperienceProgressBarState();
}

class _ExperienceProgressBarState extends State<ExperienceProgressBar>
    with TickerProviderStateMixin {
  int _previousExperienceAmount = 0;
  bool _isProgressAnimationActive = false;

  final LevelProgressPercentageCalculator _progressPercentageCalculator =
      GetIt.I();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        final currentExperience = state.profile.experience;

        _previousExperienceAmount = currentExperience;

        if (state is! ProfileLoaded &&
            currentExperience == _previousExperienceAmount) {
          return;
        }

        setState(() => _isProgressAnimationActive = true);

        Timer(
          const Duration(seconds: 5),
          () => setState(() => _isProgressAnimationActive = false),
        );
      },
      builder: (primaryBuildContext, state) {
        if (state is! ProfileLoaded) {
          return const SizedBox();
        }

        final experience = state.profile.experience;
        final progressPercent =
            _progressPercentageCalculator(experience).floor();
        final widgetProgress = double.parse('${progressPercent / 100}');

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Positioned(
            child: Container(
              height: 15,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 0),
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 700),
                tween: Tween<double>(begin: 0, end: widgetProgress),
                builder: (context, double value, Widget? child) {
                  if (_isProgressAnimationActive) {
                    return LiquidLinearProgressIndicator(
                      value: value,
                      borderRadius: 0,
                      borderWidth: 0.0,
                      direction: Axis.horizontal,
                      borderColor: Colors.transparent,
                      center: Text('$progressPercent%'),
                      backgroundColor: widget.themeData.backgroundColor,
                      valueColor: AlwaysStoppedAnimation(
                        widget.themeData.primaryColor,
                      ),
                    );
                  } else {
                    return Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          height: 15,
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 0),
                          child: LinearProgressIndicator(
                            value: value,
                            backgroundColor: widget.themeData.backgroundColor,
                            valueColor: AlwaysStoppedAnimation(
                              widget.themeData.primaryColor,
                            ),
                          ),
                        ),
                        Text('$progressPercent%')
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
