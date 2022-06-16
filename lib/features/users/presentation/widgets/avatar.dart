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
        return BlocBuilder<AuthentificationCubit, AuthentificationState>(
          builder: (BuildContext context, authentication) {
            if (authentication is Authenticated && profileState is ProfileLoaded) {
              return Chip(
                label: Text(
                  _levelCalculator(profileState.profile?.points ?? 0).value.toString(),
                ),
                avatar: CircleAvatar(
                  foregroundImage: authentication.user.avatar == null
                      ? null
                      : NetworkImage(authentication.user.avatar!),
                ),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
