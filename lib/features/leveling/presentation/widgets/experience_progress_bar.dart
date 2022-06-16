import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_next_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ExperienceProgressBar extends StatelessWidget {
  final _userLevelCalculator = GetIt.I<UserLevelCalculator>();
  final _experienceToNextLevelCalculator =
      GetIt.I<ExperienceToNextLevelCalculator>();
  ExperienceProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const SizedBox();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final currentExperince = state.profile?.experience ?? 0;
        final level = _userLevelCalculator(currentExperince);
        final experienceToNextLevel =
            _experienceToNextLevelCalculator(level + 1);
        final experienceToCurrentLevel =
            _experienceToNextLevelCalculator(level);

        final differenceBetweenLevels =
            experienceToNextLevel - experienceToCurrentLevel;
        final userProgressInPoints =
            currentExperince - experienceToCurrentLevel;
        final progressPercent =
            (userProgressInPoints * 100) / differenceBetweenLevels;
        final percentage = double.parse('0.${progressPercent.floor().toInt()}');

        // debugPrint('progressPercent: ${progressPercent}');
        // debugPrint('Animation percentage in double: ${percentage}');

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Positioned(
            child: Container(
              width: double.infinity,
              height: 15,
              padding: const EdgeInsets.only(bottom: 0),
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 700),
                tween: Tween<double>(begin: 0, end: percentage),
                builder: (BuildContext context, double value, Widget? child) {
                  return LiquidLinearProgressIndicator(
                    value: value,
                    borderRadius: 0,
                    borderWidth: 0.0,
                    borderColor: Colors.grey,
                    direction: Axis.horizontal,
                    center: Text("${(percentage * 100).floor().toInt()}%"),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
