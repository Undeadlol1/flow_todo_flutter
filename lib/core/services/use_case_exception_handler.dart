import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

import '../../features/common/services/snackbar_service.dart';

@singleton
class UseCaseExceptionHandler {
  final SnackbarService snackbarService;
  final FirebaseCrashlytics firebaseCrashlytics;

  const UseCaseExceptionHandler({
    required this.snackbarService,
    required this.firebaseCrashlytics,
  });

  void call(Object error, StackTrace stackTrace) {
    log('error: ${error.toString()}', stackTrace: stackTrace);
    snackbarService.displaySnackbar(text: error.toString());
    firebaseCrashlytics.recordError(
      error,
      stackTrace,
      reason: 'use case thrown an exception',
    );
  }
}
