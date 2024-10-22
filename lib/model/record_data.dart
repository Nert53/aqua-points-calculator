import 'package:fina_points_calculator/utils/date_func.dart';
import 'package:intl/intl.dart';

class RecordData {
  final String athlete;
  final String nationality;
  final String pool;
  final String event;
  final String eventDistance;
  final String eventStroke;
  final String time;
  final List<String> splits;
  final List<String> sectionTimes;
  final bool split25;
  final String date;
  final String competition;
  final String locationCity;
  final String locationCountry;
  final bool isNew;

  RecordData({
    required this.athlete,
    required this.nationality,
    required this.pool,
    required this.event,
    required this.eventDistance,
    required this.eventStroke,
    required this.time,
    required this.splits,
    required this.sectionTimes,
    required this.split25,
    required this.date,
    required this.competition,
    required this.locationCity,
    required this.locationCountry,
    required this.isNew,
  });

  factory RecordData.fromJson(Map<String, dynamic> json) {
    String originalDate = json['Date'] as String;
    var date = originalDate.split('-');
    String day = date[0];
    String month = convertMonthShortcutToName(date[1]);
    String year = date[2];

    String event = json['Event'] as String;
    String eventDistance = event.split(' ')[1];
    String eventStroke = event.split(' ')[2].toLowerCase();

    List<String> splits = json['Splits'].toString().trim().split(',');
    List<String> sectionTimes = calculateSectionTimes(splits);
    bool split25;
    try {
      split25 = (double.parse(splits[0]) < 20);
    } catch (e) {
      split25 = false;
    }
    

    bool isNew = false;
    DateTime now = DateTime.now();
    DateTime recordDate = DateFormat('dd-MM-yyyy')
        .parse('$day-${convertMontToInt(date[1])}-20$year');
    if (now.difference(recordDate).inDays < 365) {
      isNew = true;
    }

    return RecordData(
      athlete: json['Athlete'] as String,
      nationality: json['NF Code'] as String,
      pool: json['Pool'] as String,
      event: json['Event'] as String,
      eventDistance: eventDistance,
      eventStroke: eventStroke,
      time: json['Time'] as String,
      splits: splits,
      sectionTimes: sectionTimes,
      split25: split25,
      date: '$day. $month 20$year',
      competition: json['Competition'] as String,
      locationCity: json['City'] as String,
      locationCountry: json['Country'] as String,
      isNew: isNew,
    );
  }
}

List<String> calculateSectionTimes(List<String> splits) {
  List<double> splitTimesInSeconds = splits.map(timeToSeconds).toList();

  List<String> sectionTimes = [];
  for (int i = 0; i < splitTimesInSeconds.length - 1; i++) {
    double sectionTime = splitTimesInSeconds[i + 1] - splitTimesInSeconds[i];
    sectionTimes.add(sectionTime.toStringAsFixed(2).trim());
  }
  sectionTimes.insert(0, splitTimesInSeconds[0].toStringAsFixed(2).trim());

  return sectionTimes;
}

double timeToSeconds(String time) {
  if (time == '') {
    return 0.0;
  }

  List<String> parts = time.split(':');

  if (parts.length == 2) {
    // time in format MM:SS.SS
    double minutes = double.parse(parts[0]);
    double seconds = double.parse(parts[1]);
    return minutes * 60 + seconds;
  } else {
    // time format SS.SS
    return double.parse(time);
  }
}
