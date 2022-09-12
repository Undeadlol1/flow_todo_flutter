import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
              child: AvatarImage(radius: radius),
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

bool _hasExperienceChanged(ProfileState previous, ProfileState current) {
  return previous.profile.experience != current.profile.experience;
}
