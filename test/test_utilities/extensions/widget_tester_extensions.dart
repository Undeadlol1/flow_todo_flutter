import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension DependenciesExtension on WidgetTester {
  Future<void> pumpWithDependencies({
    required Widget child,
  }) {
    // ignore: unnecessary_this
    return this.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: child,
      ),
    );
  }

  Future<void> pumpMaterialApp({
    required Widget child,
  }) {
    // ignore: unnecessary_this
    return this.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(child: child),
      ),
    );
  }
}
