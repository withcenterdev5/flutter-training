// Create the counter model with initial state
import 'package:flutter/foundation.dart';

class CounterModel extends ChangeNotifier {
  // Initial state for count value
  int count = 4;

  // Increment method
  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }
}
