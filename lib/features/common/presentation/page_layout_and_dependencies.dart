import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart' show SignOutButton;
import 'package:get_it/get_it.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:countup/countup.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../tasks/domain/use_cases/go_to_task_creation.dart';
import '../../users/presentation/cubit/profile_cubit.dart';
import '../../users/presentation/widgets/avatar.dart';

class PageLayoutAndDependencies extends StatelessWidget {
  final Widget child;
  final bool? isFABHidden;
  final bool? isDrawerHidden;
  const PageLayoutAndDependencies({
    Key? key,
    required this.child,
    this.isFABHidden = true,
    this.isDrawerHidden = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: BlocBuilder<AuthentificationCubit, AuthentificationState>(
        builder: (BuildContext context, authentication) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            drawer: isDrawerHidden == true ? null : const _Drawer(),
            appBar: AppBar(
              actions: [
                const _Points(),
                Avatar(),
                const SizedBox(width: 8),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      child,
                      const ListenerThatRunsFunctionsWithBuildContext(),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: isFABHidden == true
                ? null
                : Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FloatingActionButton(
                      onPressed: () => GetIt.I<GoToTaskCreation>()(),
                      child: const Icon(Icons.add),
                    ),
                  ),
            bottomNavigationBar: const _BottomNavigation(),
          );
        },
      ),
    );
  }
}

class _Points extends StatefulWidget {
  const _Points({Key? key}) : super(key: key);

  @override
  State<_Points> createState() => _PointsState();
}

class _PointsState extends State<_Points> {
  double _animateNumbersFrom = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (_, __) {},
      listenWhen: (current, next) {
        final currentPoints = current.profile?.points.toDouble() ?? 0;
        _animateNumbersFrom = currentPoints;
        return true;
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoaded) {
            return Container(
              padding: const EdgeInsets.only(right: 7),
              child: Chip(
                label: Row(
                  children: [
                    const Text('Points: '),
                    Countup(
                      begin: _animateNumbersFrom,
                      end: profileState.profile?.points.toDouble() ?? 0,
                      duration: const Duration(seconds: 3),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // ignore: dead_code
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: WaterDropNavBar(
        waterDropColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onItemSelected: (index) {
          // setState(() {
          //   selectedIndex = index;
          // });
          // pageController.animateToPage(selectedIndex,
          //     duration: const Duration(milliseconds: 400),
          //     curve: Curves.easeOutQuad);
        },
        // selectedIndex: selectedIndex,
        selectedIndex: 1,
        barItems: [
          BarItem(
            filledIcon: Icons.bookmark_rounded,
            outlinedIcon: Icons.bookmark_border_rounded,
          ),
          BarItem(
            filledIcon: Icons.favorite_rounded,
            outlinedIcon: Icons.favorite_border_rounded,
          ),
        ],
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (BuildContext context, authentication) {
        return Drawer(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (authentication is Authenticated)
                  const SignOutButton()
                else
                  const GoogleSignInButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
