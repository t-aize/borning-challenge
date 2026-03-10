import 'package:borning_challenge_frontend/models/activity.dart';
import 'package:borning_challenge_frontend/widgets/activity_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );
  }

  group('ActivityList', () {
    testWidgets('shows empty message when no activities', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestApp(const ActivityList(activities: [])));
      expect(find.text('Aucune activité trouvée'), findsOneWidget);
    });

    testWidgets('displays activity type label in French', (
      WidgetTester tester,
    ) async {
      final activities = [
        Activity(
          id: 'a1',
          type: 'running',
          date: '2026-02-01',
          duration: 45,
          distance: 8.5,
          elevation: 120.0,
        ),
      ];
      await tester.pumpWidget(
        buildTestApp(ActivityList(activities: activities)),
      );
      expect(find.text('Course à pied'), findsOneWidget);
    });

    testWidgets('displays distance in km', (WidgetTester tester) async {
      final activities = [
        Activity(
          id: 'a1',
          type: 'cycling',
          date: '2026-02-05',
          duration: 90,
          distance: 35.0,
          elevation: 450.0,
        ),
      ];
      await tester.pumpWidget(
        buildTestApp(ActivityList(activities: activities)),
      );
      expect(find.text('35.0 km'), findsOneWidget);
    });

    testWidgets('displays formatted duration', (WidgetTester tester) async {
      final activities = [
        Activity(
          id: 'a1',
          type: 'swimming',
          date: '2026-02-10',
          duration: 90,
          distance: 2.0,
          elevation: 0.0,
        ),
      ];
      await tester.pumpWidget(
        buildTestApp(ActivityList(activities: activities)),
      );
      expect(find.text('1h 30min'), findsOneWidget);
    });

    testWidgets('displays date', (WidgetTester tester) async {
      final activities = [
        Activity(
          id: 'a1',
          type: 'running',
          date: '2026-02-01',
          duration: 45,
          distance: 8.5,
          elevation: 120.0,
        ),
      ];
      await tester.pumpWidget(
        buildTestApp(ActivityList(activities: activities)),
      );
      expect(find.text('2026-02-01'), findsOneWidget);
    });

    testWidgets('displays correct icon for activity type', (
      WidgetTester tester,
    ) async {
      final activities = [
        Activity(
          id: 'a1',
          type: 'cycling',
          date: '2026-02-05',
          duration: 90,
          distance: 35.0,
          elevation: 450.0,
        ),
      ];
      await tester.pumpWidget(
        buildTestApp(ActivityList(activities: activities)),
      );
      expect(find.byIcon(Icons.directions_bike), findsOneWidget);
    });

    testWidgets('renders multiple activities', (WidgetTester tester) async {
      final activities = [
        Activity(
          id: 'a1',
          type: 'running',
          date: '2026-02-01',
          duration: 45,
          distance: 8.5,
          elevation: 120.0,
        ),
        Activity(
          id: 'a2',
          type: 'cycling',
          date: '2026-02-05',
          duration: 90,
          distance: 35.0,
          elevation: 450.0,
        ),
        Activity(
          id: 'a3',
          type: 'swimming',
          date: '2026-02-10',
          duration: 60,
          distance: 2.0,
          elevation: 0.0,
        ),
      ];
      await tester.pumpWidget(
        buildTestApp(ActivityList(activities: activities)),
      );
      expect(find.text('Course à pied'), findsOneWidget);
      expect(find.text('Cyclisme'), findsOneWidget);
      expect(find.text('Natation'), findsOneWidget);
    });
  });
}
