import 'package:injectable/injectable.dart';

@lazySingleton
class StreakDaysInARowCalculator {
  const StreakDaysInARowCalculator();

  int call({required DateTime startsAt, DateTime? updatedAt}) {
    if (updatedAt == null) return 0;

    final differenceInDaysBetweenUpdateAndStart =
        updatedAt.difference(startsAt).inDays;

    return differenceInDaysBetweenUpdateAndStart + 1;
  }
}
