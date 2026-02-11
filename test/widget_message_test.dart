import 'package:counter/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('should show message when button is tapped', (WidgetTester tester) async {
    // 1. Load the widget
    await tester.pumpWidget(const MaterialApp(home: MessageWidget()));

    // 2. Check that the message is NOT there yet
    expect(find.text('Hello Flutter!'), findsNothing);

    // 3. Tap the button
    await tester.tap(find.byType(ElevatedButton));
    
    // 4. Re-render the UI (Important!)
    await tester.pump();

    // 5. Check if the message appeared
    expect(find.text('Hello Flutter!'), findsOneWidget);
  });
}