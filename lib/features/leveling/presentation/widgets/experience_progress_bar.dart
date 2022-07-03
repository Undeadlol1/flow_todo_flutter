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
  final LevelProgressPercentageCalculator _progressPercentageCalculator =
      GetIt.I();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (primaryBuildContext, state) {
        double widgetProgress = 0.0;
        if (state is! ProfileLoaded) {
          return const SizedBox();
        } else {
          final experience = (state.profile?.experience ?? 0);
          final progressPercent =
              _progressPercentageCalculator(experience).floor();
          widgetProgress = double.parse('${progressPercent / 100}');

          return Directionality(
            textDirection: TextDirection.ltr,
            child: Positioned(
              child: Container(
                width: double.infinity,
                height: 15,
                padding: const EdgeInsets.only(bottom: 0),
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 700),
                  tween: Tween<double>(begin: 0, end: widgetProgress),
                  builder: (BuildContext context, double value, Widget? child) {
                    return LiquidLinearProgressIndicator(
                      value: value,
                      borderRadius: 0,
                      borderWidth: 0.0,
                      direction: Axis.horizontal,
                      borderColor: Colors.transparent,
                      center: Text("$progressPercent%"),
                      backgroundColor: widget.themeData.backgroundColor,
                      valueColor: AlwaysStoppedAnimation(
                        widget.themeData.primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
