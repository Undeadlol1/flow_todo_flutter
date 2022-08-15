import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/presentation/pages/main_page.dart';

@injectable
class GoToMainPage {
  final BuildContextProvider contextProvider;
  const GoToMainPage({required this.contextProvider});

  Future<void> call() async {
    return contextProvider(
      (context) {
        Navigator.of(context).popUntil(ModalRoute.withName(MainPage.pathName));
      },
    );
  }
}
