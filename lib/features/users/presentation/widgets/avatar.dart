import 'package:extended_image/extended_image.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../../leveling/domain/services/user_level_calculator.dart';
import '../cubit/profile_cubit.dart';
import '../pages/profile_page.dart';

class Avatar extends StatelessWidget {
  final _levelCalculator = GetIt.I<UserLevelCalculator>();
  Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          final level =
              _levelCalculator(profileState.profile?.experience ?? 0).value;

          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProfilePage.pathName);
            },
            child: Chip(
              visualDensity: VisualDensity.compact,
              avatar: const _Image(),
              label: AnimatedNumbers(
                number: level,
                duration: const Duration(seconds: 1),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (BuildContext context, authentication) {
        if (authentication is! Authenticated) {
          return const SizedBox();
        }

        return CircleAvatar(
          foregroundImage: authentication.user.avatar == null
              ? null
              : ExtendedNetworkImageProvider(
                  authentication.user.avatar!,
                  scale: 0.1,
                  cache: true,
                  cacheMaxAge: const Duration(days: 4),
                ),
        );
      },
    );
  }
}
