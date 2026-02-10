import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterModel
    extends
        ChangeNotifier {
  int count = 4;

  void increment() {
    count++;
    notifyListeners();
  }
}

void
main() {
  runApp(
    ChangeNotifierProvider(
      create:
          (
            _,
          ) => CounterModel(),
      child: MaterialApp(
        home: CounterWidget(),
      ),
    ),
  );
}

class CounterWidget
    extends
        StatelessWidget {
  const CounterWidget({
    super.key,
  });

  @override
  build(
    context,
  ) {
    final countProvider =
        Provider.of<
          CounterModel
        >(
          context,
        );
    return Column(
      children: [
        Text(
          "Counter: ${countProvider.count} ",
        ),
        ElevatedButton(
          onPressed: () {
            countProvider.count++;
            countProvider.increment();
          },
          child: Text(
            "Increment",
          ),
        ),
      ],
    );
  }
}
