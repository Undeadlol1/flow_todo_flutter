import 'package:injectable/injectable.dart';

@lazySingleton
class StreakDaysInARowCalculator {
  const StreakDaysInARowCalculator();

  int call({required DateTime startsAt, int? updatedAt}) {
    if (updatedAt == null) return 0;

    final updateDate = DateTime.fromMillisecondsSinceEpoch(updatedAt);
    final differenceInDaysBetweenUpdateAndStart =
        updateDate.difference(startsAt).inDays;

    return differenceInDaysBetweenUpdateAndStart + 1;
  }
}
