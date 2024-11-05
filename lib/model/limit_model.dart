class Limit {
  final String limitType;
  final String eventDistance;
  final String eventStroke;
  final double time;
  final String gender;

  Limit({
    required this.limitType,
    required this.eventDistance,
    required this.eventStroke,
    required this.time,
    required this.gender,
  });

  factory Limit.fromJson(Map<String, dynamic> json) {
    return Limit(
      limitType: json['limitType'],
      eventDistance: json['eventDistance'],
      eventStroke: json['eventStroke'],
      time: json['time'] as double,
      gender: json['gender'],
    );
  }
}
