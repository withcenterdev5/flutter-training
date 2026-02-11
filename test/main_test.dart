import 'package:flutter_test/flutter_test.dart';
import 'package:counter/main.dart'; // This will error because we haven't made MyApp yet
import 'package:counter/message_widget.dart';

void main() {
  testWidgets('Root widget should load and show MessageWidget', (WidgetTester tester) async {
    // 1. Tell Flutter to run the whole app
    await tester.pumpWidget(const MyApp());

    // 2. Check if our MessageWidget is actually there
    expect(find.byType(MessageWidget), findsOneWidget);
  });
}