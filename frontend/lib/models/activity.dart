class Activity {
  final String id;
  final String type;
  final String date;
  final int duration; // minutes
  final double distance; // kilometers
  final double elevation; // meters

  Activity({
    required this.id,
    required this.type,
    required this.date,
    required this.duration,
    required this.distance,
    required this.elevation,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      type: json['type'] as String,
      date: json['date'] as String,
      duration: json['duration'] as int,
      distance: (json['distance'] as num).toDouble(),
      elevation: (json['elevation'] as num).toDouble(),
    );
  }
}
