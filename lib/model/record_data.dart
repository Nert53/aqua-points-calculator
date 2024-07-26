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
  });

  factory RecordData.fromJson(Map<String, dynamic> json) {
    String originalDate = json['Date'] as String;
    var date = originalDate.split('-');
    String day = date[0];
    String month = convertMonthToInt(date[1]);
    String year = date[2];

    String event = json['Event'] as String;
    String eventDistance = event.split(' ')[1];
    String eventStroke = event.split(' ')[2].toLowerCase();

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
    );
  }
}

String convertMonthToInt(String month) {
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
