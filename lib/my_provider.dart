import 'package:counter/constants/app_colors.dart';
import 'package:counter/constants/app_content_elements.dart';
import 'package:counter/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Create the counter counterState with initial state

class CounterState extends ChangeNotifier {
  // Initial state for count value
  int count = 4;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }

  void reset(){
    count = 0;
    notifyListeners();
  }

  void incrementByAmount(int value){
    count += value;
    notifyListeners();
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  
  final TextEditingController textEditingController = .new();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Center(
        child: // Rebuild the text widget to display the updated state
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Consumer<CounterState>(
                  builder:(context,counterState,child,) => Center(
                      child: Text(
                        "${AppStrings.counterLabel} ${counterState.count}", 
                        style: TextStyle(
                        color: AppColors.dark, 
                        fontSize: AppContentElements.header
                      )
                    )
                  ),
                ),
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: AppStrings.typeCountLabel
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final value = int.tryParse(textEditingController.text);
                    if (value != null){
                      context.read<CounterState>().incrementByAmount(value);
                    } else {
            
                    }
                  }, 
                  child: Text(AppStrings.incrementButtonLabel)
                )
              ],
            ),
          )
      ),
      //Buttons for incrementing and decrmenting the count value from the count counterState
      floatingActionButton: Column(
        spacing: 20.0,
        mainAxisAlignment: .end,
        children: [
          // Calls the increment method from the counter counterState
          FloatingActionButton(
            onPressed: () => context.read<CounterState>().increment(),
            child: Icon(Icons.add),
          ),
          // Calls the decrement method fro the counter counterState
          FloatingActionButton(
            onPressed: () => context.read<CounterState>().decrement(),
            child: Icon(Icons.remove),
          ),
          // Calls the reset method fro the counter counterState
          FloatingActionButton(
            onPressed: () => context.read<CounterState>().reset(),
            child: Icon(Icons.refresh),
          ),
        ],
      )

    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create:(_,) => CounterState(),
      child: MaterialApp(
        title: AppStrings.appName,
        home: CounterWidget(),
      ),
    ),
  );
}
