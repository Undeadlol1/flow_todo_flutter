import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@singleton
class UniqueIdGenerator {
  String call() {
    return const Uuid().v4();
  }
}
