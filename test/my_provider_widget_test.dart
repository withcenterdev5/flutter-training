import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:counter/my_provider.dart';
import 'package:counter/models/counter_model.dart';

void main() {
  group('CounterWidget', () {
    testWidgets('displays initial counter value', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CounterModel(),
          child: MaterialApp(home: CounterWidget()),
        ),
      );

      expect(find.text('Count: 4'), findsOneWidget);
    });

    testWidgets('increment button increases counter', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CounterModel(),
          child: MaterialApp(home: CounterWidget()),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('Count: 5'), findsOneWidget);
    });

    testWidgets('text field and button increment by amount', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CounterModel(),
          child: MaterialApp(home: CounterWidget()),
        ),
      );

      await tester.enterText(find.byType(TextField), '5');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Count: 9'), findsOneWidget);
    });
  });
}