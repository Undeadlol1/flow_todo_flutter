import 'package:build_context_provider/build_context_provider.dart';

class MockBuildContextProvider implements BuildContextProvider {
  num numberOfCalls = 0;

  void reset() {
    numberOfCalls = 0;
  }

  void provideBuildContext(dynamic args) {
    numberOfCalls = numberOfCalls + 1;
  }
}
