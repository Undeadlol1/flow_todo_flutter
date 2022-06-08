import '../../../tasks/domain/task.dart';
import '../entities/confidence.dart';
import '../entities/repetition.dart';

class NextRepetitionCalculator {
  NextRepetitionCalculator();

  get _now => DateTime.now();

  Repetition call({
    required Task task,
    Confidence confidence = Confidence.normal,
  }) {
    final List<DateTime> levels = [
      _addDays(2),
      _addDays(3),
      _addDays(5),
      _addDays(8),
      _addDays(14),
      _addDays(28),
      _addMonths(2),
      _addMonths(3),
      _addMonths(6)
    ];

    int newLevelIndex = -1;

    if (task.repetitionLevel != null || task.repetitionLevel == 0) {
      newLevelIndex = task.repetitionLevel ?? 0;
    }

    switch (confidence) {
      case Confidence.normal:
        newLevelIndex += 1;
        break;
      case Confidence.good:
        newLevelIndex += 2;
        break;
      case Confidence.bad:
        newLevelIndex -= 2;
        break;
      default:
    }

    if (newLevelIndex < 0) {
      newLevelIndex = 0;
    } else if (newLevelIndex >= levels.length) {
      newLevelIndex = levels.length - 1;
    }

    final int dueAt = levels[newLevelIndex].millisecondsSinceEpoch;

    return Repetition(
      dueAt: dueAt,
      repetitionLevel: newLevelIndex,
    );
  }

  DateTime _addDays(int days) {
    return _now.add(Duration(days: days));
  }

  DateTime _addMonths(int months) {
    return _now.add(Duration(days: months * 28));
  }
}
