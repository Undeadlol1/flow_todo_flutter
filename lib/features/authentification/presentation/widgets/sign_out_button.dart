import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/use_cases/logout.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => GetIt.I<Logout>()(),
      child: const Text('Logout'),
    );
  }
}
