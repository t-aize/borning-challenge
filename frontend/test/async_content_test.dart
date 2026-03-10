import 'package:borning_challenge_frontend/widgets/async_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  group('AsyncContent', () {
    testWidgets('shows CircularProgressIndicator when loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          AsyncContent<String>(
            loading: true,
            error: null,
            data: null,
            onRetry: () {},
            builder: (data) => Text(data),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Réessayer'), findsNothing);
    });

    testWidgets('shows error message and retry button on error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          AsyncContent<String>(
            loading: false,
            error: 'Something went wrong',
            data: null,
            onRetry: () {},
            builder: (data) => Text(data),
          ),
        ),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Réessayer'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('calls onRetry when retry button is tapped', (
      WidgetTester tester,
    ) async {
      var retryCalled = false;

      await tester.pumpWidget(
        buildTestApp(
          AsyncContent<String>(
            loading: false,
            error: 'Error occurred',
            data: null,
            onRetry: () => retryCalled = true,
            builder: (data) => Text(data),
          ),
        ),
      );

      await tester.tap(find.text('Réessayer'));
      expect(retryCalled, isTrue);
    });

    testWidgets('shows "Aucune donnée" when data is null and no error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          AsyncContent<String>(
            loading: false,
            error: null,
            data: null,
            onRetry: () {},
            builder: (data) => Text(data),
          ),
        ),
      );

      expect(find.text('Aucune donnée'), findsOneWidget);
    });

    testWidgets('shows builder content when data is available', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          AsyncContent<String>(
            loading: false,
            error: null,
            data: 'Hello World',
            onRetry: () {},
            builder: (data) => Text(data),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
