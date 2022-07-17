import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../leveling/domain/services/user_level_calculator.dart';
import '../../../users/presentation/cubit/profile_cubit.dart';

class ActiveQuest extends StatelessWidget {
  ActiveQuest({Key? key}) : super(key: key);
  final _levelCalculator = GetIt.I<UserLevelCalculator>();

  static const _padding = EdgeInsets.only(
    left: 16,
    right: 16,
    bottom: 4,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          final level =
              _levelCalculator(profileState.profile?.experience ?? 0).value;

          return Padding(
            padding: _padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: level.toDouble()),
                const Text('Quest: reach level 20'),
                const _ProgressBar(),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: LinearProgressIndicator(value: 0.5),
    );
  }
}
