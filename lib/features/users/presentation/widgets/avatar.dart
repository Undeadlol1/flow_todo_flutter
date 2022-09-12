import 'package:extended_image/extended_image.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_circular_progress_indicator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/presentation/widgets/floating_experience_points_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../leveling/domain/services/level_progress_percentage_calculator.dart';
import '../../../leveling/domain/services/user_level_calculator.dart';
import '../cubit/profile_cubit.dart';
import '../pages/profile_page.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final bool isLevelHidden;
  final bool areNumberAnimationsSuspended;
  const Avatar({
    Key? key,
    this.isLevelHidden = false,
    this.areNumberAnimationsSuspended = true,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(width: radius * 2),
      child: Stack(
        children: [
          GestureDetector(
            onTap: _navigateToProfilePage(context),
            child: Center(
              child: _Image(radius: radius),
            ),
          ),
          isLevelHidden
              ? const SizedBox()
              : Positioned(
                  bottom: 0,
                  width: radius,
                  right: radius / 2,
                  height: radius / 2,
                  child: _LevelBadge(radius: radius),
                ),
        ],
      ),
    );
  }

  void Function()? _navigateToProfilePage(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == ProfilePage.pathName
        ? null
        : () => Navigator.of(context).pushNamed(ProfilePage.pathName);
  }
}

class _LevelBadge extends StatelessWidget {
  final double radius;
  _LevelBadge({Key? key, required this.radius}) : super(key: key);
  final _levelCalculator = GetIt.I<UserLevelCalculator>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: _hasExperienceChanged,
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          final level = _levelCalculator(profileState.profile.experience)
              .value
              .toString();

          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              level,
              style: TextStyle(
                fontSize: radius >= 50 ? radius / 3.8 : radius / 1.5,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _Image extends StatefulWidget {
  final double radius;
  const _Image({Key? key, required this.radius}) : super(key: key);

  @override
  State<_Image> createState() => _ImageState();
}

class _ImageState extends State<_Image> {
  final LevelProgressPercentageCalculator _progressPercentageCalculator =
      GetIt.I();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: _hasExperienceChanged,
      builder: (context, profileState) {
        if (profileState is! ProfileLoaded) {
          return const SizedBox();
        }

        final lineWidth = widget.radius / 10;

        return AnimatedCircularProgressIndicator(
          percent: _getLevelProgress(profileState),
          radius: widget.radius,
          lineWidth: lineWidth,
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
                      _getImageProvider(profileState.profile.id),
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
