import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampSerializer implements JsonConverter<DateTime, String> {
  const TimestampSerializer();

  @override
  DateTime fromJson(String timestamp) => DateTime.parse(timestamp);

  @override
  String toJson(DateTime date) => DateFormat('yyyy-MM-dd kk:mm').format(date);
}
