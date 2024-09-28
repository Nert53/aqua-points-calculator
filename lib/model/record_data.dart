import 'package:intl/intl.dart';

class RecordData {
  final String athlete;
  final String nationality;
  final String pool;
  final String event;
  final String eventDistance;
  final String eventStroke;
  final String time;
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
      date: '$day. $month 20$year',
      competition: json['Competition'] as String,
      locationCity: json['City'] as String,
      locationCountry: json['Country'] as String,
      isNew: isNew,
    );
  }
}

String convertMonthShortcutToName(String month) {
  switch (month) {
    case 'Jan':
      return 'January';
    case 'Feb':
      return 'February';
    case 'Mar':
      return 'March';
    case 'Apr':
      return 'April';
    case 'May':
      return 'May';
    case 'Jun':
      return 'June';
    case 'Jul':
      return 'July';
    case 'Aug':
      return 'August';
    case 'Sep':
      return 'September';
    case 'Oct':
      return 'October';
    case 'Nov':
      return 'November';
    case 'Dec':
      return 'December';
    default:
      return 'Invalid month';
  }
}

int convertMontToInt(String month) {
  switch (month) {
    case 'Jan':
      return 1;
    case 'Feb':
      return 2;
    case 'Mar':
      return 3;
    case 'Apr':
      return 4;
    case 'May':
      return 5;
    case 'Jun':
      return 6;
    case 'Jul':
      return 7;
    case 'Aug':
      return 8;
    case 'Sep':
      return 9;
    case 'Oct':
      return 10;
    case 'Nov':
      return 11;
    case 'Dec':
      return 12;
    default:
      return 1;
  }
}
