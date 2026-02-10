
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterState with ChangeNotifier {
  int count = 0;

  static CounterState of(BuildContext context) =>
      Provider.of<CounterState>(context, listen: false);

  void increment() {
    count++;
    notifyListeners();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChangeNotifierProvider(
        create: (context) => CounterState(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<CounterState>(context).count;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          children: [
            Text("Updated code here: $count"),
            ElevatedButton(
              onPressed: () => CounterState.of(context).increment(),
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}



