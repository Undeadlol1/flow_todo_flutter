import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../features/common/services/snackbar_service.dart';

@singleton
class UseCaseExceptionHandler {
  final SnackbarService snackbarService;

  const UseCaseExceptionHandler({required this.snackbarService});

  void handleException(Object error) {
    log('error: ${error.toString()}');
    snackbarService.displaySnackbar(text: error.toString());
  }
}
