import 'dart:developer';

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

class Avatar extends StatelessWidget {
  final double radius;
  final bool areNumberAnimationsSuspended;
  const Avatar({
    Key? key,
    this.areNumberAnimationsSuspended = true,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: radius * 2),
      child: Stack(
        children: [
          InkWell(
            child: Center(
              child: _Image(radius: radius),
            ),
            onTap: () => Navigator.of(context).pushNamed(ProfilePage.pathName),
          ),
          Positioned(
            bottom: 0,
            width: radius,
            right: radius / 2,
            height: radius / 2,
            child: Center(
              child: _LevelBadge(radius: radius),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final double radius;
  _LevelBadge({Key? key, required this.radius}) : super(key: key);
  final _levelCalculator = GetIt.I<UserLevelCalculator>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          final level = _levelCalculator(profileState.profile?.experience ?? 0)
              .value
              .toString();

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(4),
            child: Text(
              level,
              style:
                  TextStyle(fontSize: radius >= 50 ? radius / 5 : radius / 1.5),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _Image extends StatefulWidget {
  const _Image({Key? key, required this.radius}) : super(key: key);
  final double radius;

  @override
  State<_Image> createState() => _ImageState();
}

// TODO refactor everything. Was tired while writing this code.
class _ImageState extends State<_Image> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool isStatusListenerAdded = false;
  double previousValueOfProgressCircle = 0;
  final LevelProgressPercentageCalculator _progressPercentageCalculator =
      GetIt.I();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = useAnimationController(
    //   duration: const Duration(seconds: 1),
    // );
    // final animation = useAnimation(controller);
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (context, authState) {
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, profileState) {
            if (profileState is! ProfileLoaded) return;

            final experience = (profileState.profile?.experience ?? 0);

            final progressPercent =
                _progressPercentageCalculator(experience).floor();
            final widgetProgress = double.parse('${progressPercent / 100}');
            log('widgetProgress: $widgetProgress');
            log('previousValueOfProgressCircle: $previousValueOfProgressCircle');

            animation = Tween<double>(
              end: widgetProgress,
              begin: previousValueOfProgressCircle,
            ).animate(controller);

            if (isStatusListenerAdded == false) {
              animation.addListener(
                () => setState(() {
                  // log('SETSTATE');
                }),
              );
              animation.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  log('COMPLETE');
                }
              });
              isStatusListenerAdded = true;
            }
            // log('ABOUT to forward');
            controller.reset();
            controller.forward();
          },
          builder: (BuildContext context, profileState) {
            if (profileState is! ProfileLoaded || authState is! Authenticated) {
              return const SizedBox();
            }

            final experience = (profileState.profile?.experience ?? 0);
            final progressPercent =
                _progressPercentageCalculator(experience).floor();
            final widgetProgress = double.parse('${progressPercent / 100}');
            final lineWidth = widget.radius / 10;

            previousValueOfProgressCircle = widgetProgress;
            log('animation.value: ${animation.value}');
            // log('animation details: ${animation.toStringDetails()}');

            return CircularPercentIndicator(
              lineWidth: lineWidth,
              percent: animation.value,
              radius: widget.radius + lineWidth,
              progressColor: Theme.of(context).colorScheme.primary,
              center: CircleAvatar(
                radius: widget.radius,
                backgroundImage: authState.user.avatar == null
                    ? null
                    : ExtendedNetworkImageProvider(
                        authState.user.avatar!,
                        scale: 1,
                        cache: true,
                        cacheMaxAge: const Duration(days: 4),
                      ),
                // child: CircularProgressIndicator(value: widgetProgress),
              ),
            );
          },
        );
      },
    );
  }
}
