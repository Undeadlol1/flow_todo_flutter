import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ExperienceProgressBar extends StatelessWidget {
  final LevelProgressPercentageCalculator _progressPercentageCalculator = GetIt.I();
  ExperienceProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const SizedBox();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        double widgetProgress = 0.0;
        if (state is! ProfileLoaded) {
          return const SizedBox();
        } else {
          final experience = (state.profile?.experience ?? 0) + 400;
          final progressPercent = _progressPercentageCalculator(experience).floor();
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
                      borderColor: Colors.grey,
                      direction: Axis.horizontal,
                      center: Text("$progressPercent%"),
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
