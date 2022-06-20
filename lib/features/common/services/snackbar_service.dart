import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';

class SnackbarService {
  final BuildContextProvider buildContextProvider;
  const SnackbarService({required this.buildContextProvider});

  void displaySnackbar({required String text}) {
    buildContextProvider(
      (context) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 20),
          ),
        );
      },
    );
  }
}
