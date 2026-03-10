import 'package:borning_challenge_frontend/models/activity.dart';
import 'package:borning_challenge_frontend/models/activity_stats.dart';
import 'package:borning_challenge_frontend/widgets/stats_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return MaterialApp(
      home: Scaffold(body: SizedBox(width: 900, height: 600, child: child)),
    );
  }

  final sampleStats = ActivityStats(
    totalKm: 45.5,
    totalElevation: 570.0,
    totalDuration: 195,
    activityCount: 3,
    activities: [
      Activity(
        id: 'a1',
        type: 'running',
        date: '2026-02-10',
        duration: 60,
        distance: 2.0,
        elevation: 0.0,
      ),
    ],
  );

  group('StatsCards', () {
    testWidgets('displays total km', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(StatsCards(stats: sampleStats)));
      expect(find.text('45.5 km'), findsOneWidget);
    });

    testWidgets('displays total elevation', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(StatsCards(stats: sampleStats)));
      expect(find.text('570 m'), findsOneWidget);
    });

    testWidgets('displays total duration formatted', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestApp(StatsCards(stats: sampleStats)));
      expect(find.text('3h 15min'), findsOneWidget);
    });

    testWidgets('displays activity count', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(StatsCards(stats: sampleStats)));
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('displays all four labels', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(StatsCards(stats: sampleStats)));
      expect(find.text('Distance totale'), findsOneWidget);
      expect(find.text('Dénivelé cumulé'), findsOneWidget);
      expect(find.text('Durée totale'), findsOneWidget);
      expect(find.text('Activités'), findsOneWidget);
    });
  });
}
