import 'activity_stats.dart';

class TeamStats {
  final String teamId;
  final List<String> members;
  final ActivityStats stats;

  TeamStats({required this.teamId, required this.members, required this.stats});

  factory TeamStats.fromJson(Map<String, dynamic> json) {
    return TeamStats(
      teamId: json['team_id'] as String,
      members: (json['members'] as List).cast<String>(),
      stats: ActivityStats.fromJson(json['stats'] as Map<String, dynamic>),
    );
  }
}
