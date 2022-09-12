import 'dart:developer';

import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_circular_progress_indicator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/presentation/widgets/floating_experience_points_animation.dart';

import '../cubit/profile_cubit.dart';

class AvatarImage extends StatefulWidget {
  final double radius;
  const AvatarImage({Key? key, required this.radius}) : super(key: key);

  @override
  State<AvatarImage> createState() => _ImageState();
}

class _ImageState extends State<AvatarImage> {
  final LevelProgressPercentageCalculator _progressPercentageCalculator =
      GetIt.I();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: _hasExperienceChanged,
      builder: (context, profileState) {
        log('sdfsfsf');
        if (profileState is! ProfileLoaded) {
          return const SizedBox();
        }

        final lineWidth = widget.radius / 10;

        return AnimatedCircularProgressIndicator(
          percent: _getLevelProgress(profileState),
          lineWidth: lineWidth,
          radius: widget.radius,
          child: Stack(
            children: [
              BlocSelector<AuthentificationCubit, AuthentificationState,
                  String?>(
                selector: (state) =>
                    state is Authenticated ? state.user.avatar : null,
                builder: (context, avatar) {
                  final int preferredImageSize = (widget.radius * 6).toInt();

                  return CircleAvatar(
                    radius: widget.radius,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    backgroundImage: ResizeImage(
                      _getImageProvider(
                        'https://avatars.dicebear.com/api/adventurer-neutral/${profileState.profile.id}.svg',
                      ),
                      width: preferredImageSize,
                      height: preferredImageSize,
                    ),
                    foregroundImage: avatar == null
                        ? null
                        : ResizeImage(
                            _getImageProvider(avatar),
                            width: preferredImageSize,
                            height: preferredImageSize,
                          ),
                  );
                },
              ),
              if (widget.radius >= 60)
                Positioned(
                  width: widget.radius,
                  height: widget.radius,
                  right: widget.radius / 2,
                  bottom: widget.radius / 2,
                  child: const Center(
                    child: FloatingExperiencePointsAnimation(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  ExtendedNetworkImageProvider _getImageProvider(String url) {
    return ExtendedNetworkImageProvider(
      url,
      scale: 1,
      retries: 2,
      cache: true,
      printError: true,
      cacheMaxAge: const Duration(days: 4),
    );
  }

  double _getLevelProgress(profileState) {
    final experience = (profileState.profile?.experience ?? 0);
    final progressPercent = _progressPercentageCalculator(experience).floor();
    final widgetProgress = double.parse('${progressPercent / 100}');
    return widgetProgress;
  }
}

bool _hasExperienceChanged(ProfileState previous, ProfileState current) {
  return previous.profile.experience != current.profile.experience;
}
