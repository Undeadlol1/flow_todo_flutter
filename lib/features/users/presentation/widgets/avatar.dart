import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../../leveling/domain/services/user_level_calculator.dart';
import '../cubit/profile_cubit.dart';

class Avatar extends StatelessWidget {
  final _levelCalculator = GetIt.I<UserLevelCalculator>();
  Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          return Chip(
            avatar: const _Image(),
            label: Text(
              _levelCalculator(profileState.profile?.points ?? 0).value.toString(),
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
