import 'activity.dart';

class ActivityStats {
  final double totalKm;
  final double totalElevation;
  final int totalDuration; // minutes
  final int activityCount;
  final List<Activity> activities;

  ActivityStats({
    required this.totalKm,
    required this.totalElevation,
    required this.totalDuration,
    required this.activityCount,
    required this.activities,
  });

  factory ActivityStats.fromJson(Map<String, dynamic> json) {
    return ActivityStats(
      totalKm: (json['total_km'] as num).toDouble(),
      totalElevation: (json['total_elevation'] as num).toDouble(),
      totalDuration: json['total_duration'] as int,
      activityCount: json['activity_count'] as int,
      activities: (json['activities'] as List)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
