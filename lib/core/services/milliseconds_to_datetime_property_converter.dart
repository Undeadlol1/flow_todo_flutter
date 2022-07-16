import 'package:freezed_annotation/freezed_annotation.dart';

class MillisecondsToDateTimePropertyConverter
    implements JsonConverter<DateTime, int> {
  const MillisecondsToDateTimePropertyConverter();

  @override
  DateTime fromJson(int json) {
    return DateTime.fromMillisecondsSinceEpoch(json);
  }

  @override
  int toJson(DateTime date) {
    return date.millisecondsSinceEpoch;
  }
}
