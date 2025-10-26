import 'dart:convert';
import 'package:fina_points_calculator/model/world_record_model.dart';
import 'package:flutter/services.dart';

Future<double> findRecordTime(String gender, String course, String distance,
    String stroke, String season) async {
  gender = gender.toLowerCase();
  course = course.toLowerCase().substring(0, 3);
  distance = distance.toLowerCase().replaceAll(' ', '');
  stroke = stroke.toLowerCase();

  var allRecords = await getRecords(
      'assets/table_base_times/$season/${gender}_$course.json');
  for (var record in allRecords) {
    if (record.eventDistance == distance && record.eventStroke == stroke) {
      double minutes, seconds, hundredths;
      bool overMinuteRecord = record.time.contains(':');
      var editedTime = record.time.replaceAll(':', '.').split('.');

      if (overMinuteRecord) {
        minutes = double.parse(editedTime[0]);
        seconds = double.parse(editedTime[1]);
        hundredths = double.parse(editedTime[2]);
      } else {
        minutes = 0.0;
        seconds = double.parse(editedTime[0]);
        hundredths = double.parse(editedTime[1]);
      }

      return (minutes * 60) + seconds + (hundredths / 100);
    }
  }

  return 0.0;
}

Future<List<WorldRecord>> getRecords(String path) async {
  List<WorldRecord> records =
      (json.decode(await rootBundle.loadString(path)) as List)
          .map((record) => WorldRecord.fromJson(record))
          .toList();

  return records;
}