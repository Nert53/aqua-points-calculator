class Limit {
  final String limitType;
  final String event;
  final String eventDistance;
  final String eventStroke;
  final String time;

  Limit({
    required this.limitType,
    required this.event,
    required this.eventDistance,
    required this.eventStroke,
    required this.time,
  });

  factory Limit.fromJson(Map<String, dynamic> json) {
    String event = json['Event'] as String;
    String eventDistance = event.split(' ')[1];
    String eventStroke = event.split(' ')[2].toLowerCase();

    return Limit(
      limitType: json['LimitType'] as String,
      event: event,
      eventDistance: eventDistance,
      eventStroke: eventStroke,
      time: json['Time'] as String,
    );
  }
}