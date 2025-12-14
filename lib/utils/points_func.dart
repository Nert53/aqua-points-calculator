import 'dart:math';
import 'package:fina_points_calculator/utils/records_func.dart';

Future<int> calculatePoints(String time, String gender, String course,
    String distance, String stroke) async {
  // because of relays
  if (distance.contains('x')) {
    return 0;
  }

  // because of some empty limit B times
  if (time.isEmpty) {
    return 0;
  }

  gender = gender.toLowerCase();
  course = course.toLowerCase().substring(0, 3);
  distance = distance.toLowerCase().replaceAll(' ', '');
  stroke = stroke.toLowerCase().replaceAll(' ', '');
  double minutes, seconds, hundredths;
  bool overMinuteRecord = time.contains(':');
  var editedTime = time.replaceAll(':', '.').split('.');

  if (overMinuteRecord) {
    minutes = double.parse(editedTime[0]);
    seconds = double.parse(editedTime[1]);
    hundredths = double.parse(editedTime[2]);
  } else {
    minutes = 0.0;
    seconds = double.parse(editedTime[0]);
    hundredths = double.parse(editedTime[1]);
  }

  double overallTimeSeconds = (minutes * 60) + seconds + (hundredths / 100);

  double recordTimeSeconds =
      await findRecordTime(gender, course, distance, stroke, '25-26');
  int points = (1000 * pow(recordTimeSeconds / overallTimeSeconds, 3)).toInt();

  return points;
}
