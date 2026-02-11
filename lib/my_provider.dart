import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterModel extends ChangeNotifier {
  int _count = 4;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create:(_,) => CounterModel(),
      child: MaterialApp(
        home: CounterWidget(),
      ),
    ),
  );
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key,});

  @override
  build(context) {
    return Column(
      children: [
        Consumer<CounterModel>(
          builder: (_, model, _) => Text("Counter: ${model._count}"),
        ),
        ElevatedButton(
          onPressed: () => context.read<CounterModel>().increment(),
          child: const Text("Increment"),
        ),
      ],
    );
  }
}
