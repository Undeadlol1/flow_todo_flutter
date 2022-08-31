import 'package:extended_image/extended_image.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/leveling/presentation/widgets/floating_experience_points_animation.dart';
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

class _ImageState extends State<_Image> with SingleTickerProviderStateMixin {
  bool _isAnimationListenerAdded = false;
  bool _hasFirstAnimationForcefullyRan = false;
  double _previousValueOfProgressCircle = 0;
  late Animation<double> _animation;
  late final AnimationController _animationController;

  final LevelProgressPercentageCalculator _progressPercentageCalculator =
      GetIt.I();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      end: 0,
      begin: 0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: _runAnimation,
      builder: (BuildContext context, profileState) {
        final authState = context.watch<AuthentificationCubit>().state;

        if (profileState is! ProfileLoaded || authState is! Authenticated) {
          return const SizedBox();
        }

        if (_hasFirstAnimationForcefullyRan == false) {
          _runAnimation(context, profileState);
        }

        _previousValueOfProgressCircle = _getLevelProgress(profileState);

        final lineWidth = widget.radius / 10;
        final int preferredImageSize = (widget.radius * 6).toInt();

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CircularPercentIndicator(
              lineWidth: lineWidth,
              percent: _animation.value,
              radius: widget.radius + lineWidth,
              progressColor: Theme.of(context).colorScheme.primary,
              center: child,
            );
          },
          child: Stack(
            children: [
              CircleAvatar(
                radius: widget.radius,
                foregroundImage: authState.user.avatar == null
                    ? null
                    : ResizeImage(
                        ExtendedNetworkImageProvider(
                          authState.user.avatar!,
                          printError: true,
                          scale: 1,
                          cache: true,
                          cacheMaxAge: const Duration(days: 4),
                        ),
                        width: preferredImageSize,
                        height: preferredImageSize,
                      ),
                // child: CircularProgressIndicator(value: widgetProgress),
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

  void _runAnimation(context, profileState) {
    if (!mounted) return;
    if (profileState is! ProfileLoaded) return;

    Future.microtask(() {
      setState(() => _hasFirstAnimationForcefullyRan = true);

      _animation = Tween<double>(
        end: _getLevelProgress(profileState),
        begin: _previousValueOfProgressCircle,
      ).animate(_animationController);

      if (_isAnimationListenerAdded == false) {
        _animation.addListener(() => setState(() {}));
        _isAnimationListenerAdded = true;
      }

      _animationController
        ..reset()
        ..forward();
    });
  }

  double _getLevelProgress(profileState) {
    final experience = (profileState.profile?.experience ?? 0);
    final progressPercent = _progressPercentageCalculator(experience).floor();
    final widgetProgress = double.parse('${progressPercent / 100}');
    return widgetProgress;
  }
}
