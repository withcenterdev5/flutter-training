import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    // 2. IMPORTANT: Always dispose notifiers to prevent memory leaks!
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Value Notifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (context, value, _) {
                return Text('Count: $value');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.value++, // 3. Simply update .value
        child: Icon(Icons.add),
      ),
    );
  }
}