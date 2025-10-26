class Limit {
  final String eventDistance;
  final String eventStroke;
  final String timeA;
  final String timeB;
  final String gender;
  int pointsA;
  int pointsB;

  Limit({
    required this.eventDistance,
    required this.eventStroke,
    required this.timeA,
    required this.timeB,
    required this.gender,
    this.pointsA = 0,
    this.pointsB = 0,
  });

  factory Limit.fromJson(Map<String, dynamic> json) {
    return Limit(
      eventDistance: json['eventDistance'] as String,
      eventStroke: json['eventStroke'] as String,
      timeA: json['limitTimeA'] as String,
      timeB: json['limitTimeB'] as String,
      gender: json['gender'] as String,
    );
  }
}
