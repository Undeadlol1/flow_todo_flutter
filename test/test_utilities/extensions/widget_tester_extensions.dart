import 'package:flutter/widgets.dart';
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
}
