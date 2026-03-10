// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:borning_challenge_frontend/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App shows bottom navigation with two tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the app shows the two navigation destinations
    expect(find.text('Utilisateur'), findsOneWidget);
    expect(find.text('Équipe'), findsOneWidget);

    // Verify the initial title
    expect(find.text('Activités Utilisateur'), findsOneWidget);
  });
}
