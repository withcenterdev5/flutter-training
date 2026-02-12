import 'package:flutter/foundation.dart';

class SwitchController extends ChangeNotifier {
  bool _isSwitchOn = false;

  bool get isSwitchOn => _isSwitchOn;

  void setValue(bool value) {
    if (_isSwitchOn == value) return; // Only update if value changes
    _isSwitchOn = value;
    notifyListeners(); // Notify all listening widgets of the change
  }
}
