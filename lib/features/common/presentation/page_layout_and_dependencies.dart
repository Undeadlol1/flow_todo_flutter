import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../tasks/domain/use_cases/go_to_task_creation.dart';
import '../../users/presentation/cubit/profile_cubit.dart';
import '../../users/presentation/widgets/avatar.dart';

class PageLayoutAndDependencies extends StatelessWidget {
  final Widget child;
  final bool? isDrawerHidden;
  const PageLayoutAndDependencies({
    Key? key,
    required this.child,
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
                _buildPoints(),
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
            floatingActionButton: FloatingActionButton(
              onPressed: () => GetIt.I<GoToTaskCreation>()(),
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: const _BottomNavigation(),
          );
        },
      ),
    );
  }

  Widget _buildPoints() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          return Container(
            padding: const EdgeInsets.only(right: 7),
            child: Chip(
              label: Text('Points: ${profileState.profile?.points.toString()}'),
            ),
          );
        }
        return Container();
      },
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
          BarItem(filledIcon: Icons.favorite_rounded, outlinedIcon: Icons.favorite_border_rounded),
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
                  const SizedBox(
                    height: 300,
                    child: SignInScreen(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
