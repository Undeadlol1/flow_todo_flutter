import 'package:uuid/uuid.dart';

class UniqueIdGenerator {
  String call() {
    return const Uuid().v4();
  }
}
