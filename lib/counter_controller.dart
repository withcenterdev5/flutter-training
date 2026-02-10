import 'package:flutter/material.dart';

class CounterController {
  CounterController({required this.defaultCount});
  int defaultCount;
  late final _CounterState state;
  int get count => state.count;
  void reset() {
    state.reset();
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key, required this.controller});
  final CounterController controller;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.state = this;
    count = widget.controller.defaultCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Count: $count', style: const TextStyle(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: increment,
              child: const Text('Increment'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: decrement,
              child: const Text('Decrement'),
            ),
          ],
        ),
      ],
    );
  }
}

