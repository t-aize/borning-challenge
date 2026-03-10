import 'package:borning_challenge_frontend/models/activity.dart';
import 'package:borning_challenge_frontend/models/activity_stats.dart';
import 'package:borning_challenge_frontend/models/team_stats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Activity.fromJson', () {
    test('parses all fields correctly', () {
      final json = {
        'id': 'a1',
        'type': 'running',
        'date': '2026-02-01',
        'duration': 45,
        'distance': 8.5,
        'elevation': 120.0,
      };

      final activity = Activity.fromJson(json);

      expect(activity.id, 'a1');
      expect(activity.type, 'running');
      expect(activity.date, '2026-02-01');
      expect(activity.duration, 45);
      expect(activity.distance, 8.5);
      expect(activity.elevation, 120.0);
    });

    test('handles integer distance as double', () {
      final json = {
        'id': 'a2',
        'type': 'cycling',
        'date': '2026-02-05',
        'duration': 90,
        'distance': 35,
        'elevation': 450,
      };

      final activity = Activity.fromJson(json);

      expect(activity.distance, 35.0);
      expect(activity.elevation, 450.0);
    });
  });

  group('ActivityStats.fromJson', () {
    test('parses stats and nested activities', () {
      final json = {
        'total_km': 45.5,
        'total_elevation': 570.0,
        'total_duration': 195,
        'activity_count': 3,
        'activities': [
          {
            'id': 'a1',
            'type': 'running',
            'date': '2026-02-10',
            'duration': 60,
            'distance': 2.0,
            'elevation': 0.0,
          },
          {
            'id': 'a2',
            'type': 'cycling',
            'date': '2026-02-05',
            'duration': 90,
            'distance': 35.0,
            'elevation': 450.0,
          },
        ],
      };

      final stats = ActivityStats.fromJson(json);

      expect(stats.totalKm, 45.5);
      expect(stats.totalElevation, 570.0);
      expect(stats.totalDuration, 195);
      expect(stats.activityCount, 3);
      expect(stats.activities.length, 2);
      expect(stats.activities[0].type, 'running');
      expect(stats.activities[1].type, 'cycling');
    });

    test('handles empty activities list', () {
      final json = {
        'total_km': 0.0,
        'total_elevation': 0.0,
        'total_duration': 0,
        'activity_count': 0,
        'activities': [],
      };

      final stats = ActivityStats.fromJson(json);

      expect(stats.activityCount, 0);
      expect(stats.activities, isEmpty);
    });
  });

  group('TeamStats.fromJson', () {
    test('parses team stats with members and nested stats', () {
      final json = {
        'team_id': 'team_1',
        'members': ['user_1', 'user_2', 'user_3'],
        'stats': {
          'total_km': 100.0,
          'total_elevation': 1200.0,
          'total_duration': 300,
          'activity_count': 5,
          'activities': [
            {
              'id': 'a1',
              'type': 'running',
              'date': '2026-02-01',
              'duration': 45,
              'distance': 8.5,
              'elevation': 120.0,
            },
          ],
        },
      };

      final teamStats = TeamStats.fromJson(json);

      expect(teamStats.teamId, 'team_1');
      expect(teamStats.members.length, 3);
      expect(teamStats.members, ['user_1', 'user_2', 'user_3']);
      expect(teamStats.stats.totalKm, 100.0);
      expect(teamStats.stats.totalElevation, 1200.0);
      expect(teamStats.stats.activityCount, 5);
      expect(teamStats.stats.activities.length, 1);
    });
  });
}
