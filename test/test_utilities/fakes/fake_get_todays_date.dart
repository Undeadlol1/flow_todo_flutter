import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:mocktail/mocktail.dart';

class FakeGetTodaysDate extends Fake implements GetTodaysDate {
  final returnedValue = DateTime.now().subtract(const Duration(days: 2));

  @override
  DateTime call() => returnedValue;
}
