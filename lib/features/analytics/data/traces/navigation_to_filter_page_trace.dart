import 'package:firebase_performance/firebase_performance.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationToFilterPageTrace {
  NavigationToFilterPageTrace();

  final Trace _trace = FirebasePerformance.instance.newTrace(
    'Navigation from Main page to Filter page',
  );

  Future<void> start() async {
    return _trace.start();
  }

  Future<void> stop() async {
    return _trace.stop();
  }
}
