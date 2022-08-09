import 'package:freezed_annotation/freezed_annotation.dart';

class OptionalMillisecondsToDateTimePropertyConverter
    implements JsonConverter<DateTime?, int?> {
  const OptionalMillisecondsToDateTimePropertyConverter();

  @override
  DateTime? fromJson(int? milliseconds) {
    if (milliseconds != null) {
      return DateTime.fromMillisecondsSinceEpoch(milliseconds);
    } else {
      return null;
    }
  }

  @override
  int? toJson(DateTime? date) {
    if (date != null) {
      return date.millisecondsSinceEpoch;
    } else {
      return null;
    }
  }
}
