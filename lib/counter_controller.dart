import 'package:flutter/material.dart';

// 1. Logic Layer (ViewModel/Controller)
class CounterViewModel extends ChangeNotifier {
  int _count;
  CounterViewModel({int defaultCount = 0}) : _count = defaultCount;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // {Link: Medium https://kymoraa.medium.com/flutter-state-management-beginner-basics-counter-example-2b4c469340a6}
  }

  void decrement() {
    _count--;
    notifyListeners(); // {Link: Medium https://kymoraa.medium.com/flutter-state-management-beginner-basics-counter-example-2b4c469340a6}
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

// 2. UI Layer (Widget)
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key, required this.viewModel});
  final CounterViewModel viewModel;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  void initState() {
    super.initState();
    // Listen to changes to rebuild UI
    widget.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    // Clean up listener
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Text('Count: ${widget.viewModel.count}',
            style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(
              onPressed: widget.viewModel.increment,
              child: const Text('Increment'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: widget.viewModel.decrement,
              child: const Text('Decrement'),
            ),
          ],
        ),
      ],
    );
  }
}
