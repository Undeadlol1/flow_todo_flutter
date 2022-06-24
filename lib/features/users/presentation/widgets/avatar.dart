import 'package:extended_image/extended_image.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../leveling/domain/services/level_progress_percentage_calculator.dart';
import '../../../leveling/domain/services/user_level_calculator.dart';
import '../cubit/profile_cubit.dart';
import '../pages/profile_page.dart';

const radius = 25.0;

class Avatar extends StatelessWidget {
  final _levelCalculator = GetIt.I<UserLevelCalculator>();
  Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius + 20,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoaded) {
            final level = _levelCalculator(profileState.profile?.points ?? 0)
                .value
                .toString();

            return Stack(
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(ProfilePage.pathName),
                  child: _Image(),
                ),
                Positioned(
                  right: 0,
                  top: -5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(level),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _Image extends StatelessWidget {
  _Image({Key? key}) : super(key: key);
  final LevelProgressPercentageCalculator _progressPercentageCalculator =
      GetIt.I();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (context, authState) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (BuildContext context, profileState) {
            if (profileState is! ProfileLoaded || authState is! Authenticated) {
              return const SizedBox();
            }

            final experience = (profileState.profile?.experience ?? 0) + 400;
            final progressPercent =
                _progressPercentageCalculator(experience).floor();
            final widgetProgress = double.parse('${progressPercent / 100}');

            return CircularPercentIndicator(
              radius: radius,
              lineWidth: 5.0,
              percent: widgetProgress,
              progressColor: Theme.of(context).colorScheme.primary,
              center: CircleAvatar(
                radius: radius,
                foregroundImage: authState.user.avatar == null
                    ? null
                    : ExtendedNetworkImageProvider(
                        authState.user.avatar!,
                        scale: 1,
                        cache: true,
                        cacheMaxAge: const Duration(days: 4),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
