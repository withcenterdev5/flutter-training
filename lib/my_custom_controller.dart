import 'package:flutter/material.dart';

// ---------------------------------------------------------
// 1. Your Custom Controller
// ---------------------------------------------------------
class SwitchController extends ChangeNotifier {
  bool _isSwitchOn = false;

  bool get isSwitchOn => _isSwitchOn;

  void setValue(bool value) {
    if (_isSwitchOn == value) return; 
    _isSwitchOn = value;
    notifyListeners(); 
  }
}

void main() {
  runApp(const MaterialApp(home: SwitchScreen()));
}

// ---------------------------------------------------------
// 2. The UI Implementation
// ---------------------------------------------------------
class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  // Instantiate the controller
  final SwitchController _controller = .new();

  @override
  void dispose() {
    // Always dispose the controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller Pattern')),
      body: Center(
        // ListenableBuilder listens to the controller.
        // Whenever notifyListeners() is called, the 'builder' runs again.
        child: ListenableBuilder(
          listenable: _controller,
          builder: (BuildContext context, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.isSwitchOn ? 'Active' : 'Inactive',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Switch(
                  // Bind the UI to the controller's state
                  value: _controller.isSwitchOn,
                  // Call the controller's method on user interaction
                  onChanged: (value) => _controller.setValue(value),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}