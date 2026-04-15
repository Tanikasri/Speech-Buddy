import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speakbuddy/main.dart';

void main() {
  testWidgets('All four cards are visible and tappable', (WidgetTester tester) async {
    // Load the SpeakBuddy app
    await tester.pumpWidget(const MyApp());

    // Verify each label exists
    expect(find.text("Diet"), findsOneWidget);
    expect(find.text("Toilet"), findsOneWidget);
    expect(find.text("Help"), findsOneWidget);
    expect(find.text("Water"), findsOneWidget);

    // Tap each card
    await tester.tap(find.text("Diet"));
    await tester.pump();
    await tester.tap(find.text("Toilet"));
    await tester.pump();
    await tester.tap(find.text("Help"));
    await tester.pump();
    await tester.tap(find.text("Water"));
    await tester.pump();

    // Verify all are still visible
    expect(find.text("Diet"), findsOneWidget);
    expect(find.text("Toilet"), findsOneWidget);
    expect(find.text("Help"), findsOneWidget);
    expect(find.text("Water"), findsOneWidget);
  });
}
