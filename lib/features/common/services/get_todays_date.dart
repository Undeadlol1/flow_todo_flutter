import 'package:injectable/injectable.dart';

@singleton
class GetTodaysDate {
  DateTime call() => DateTime.now();
}
