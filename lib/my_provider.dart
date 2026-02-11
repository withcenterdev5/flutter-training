import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Create the counter model with initial state
class CounterModel extends ChangeNotifier {
  // Initial state for count value
  int _count = 4;

  // Increment method
  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key,});

  @override
  build(context,) {
    return Column(
      children: [
        // Rebuild the text widget to display the updated state
        Consumer<CounterModel>(
          builder:(_,model,_,) => Text("Counter: ${model._count}"),
        ),
        //Button for incrementing the count value from the count model
        ElevatedButton(
          onPressed: () => context.read<CounterModel>().increment(),
          child: const Text(
            "Increment",
          ),
        ),
      ],
    );
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
