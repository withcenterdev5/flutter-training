import 'package:counter/constants/app_colors.dart';
import 'package:counter/constants/app_content_elements.dart';
import 'package:counter/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter/models/counter_model.dart';

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
                Consumer<CounterModel>(
                  builder:(_,model,_,) => Center(
                      child: Text(
                        "${AppStrings.counterLabel} ${model.count}", 
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
                      context.read<CounterModel>().incrementByAmount(value);
                    } else {
            
                    }
                  }, 
                  child: Text(AppStrings.incrementButtonLabel)
                )
              ],
            ),
          )
      ),
      //Buttons for incrementing and decrmenting the count value from the count model
      floatingActionButton: Column(
        spacing: 20.0,
        mainAxisAlignment: .end,
        children: [
          // Calls the increment method from the counter model
          FloatingActionButton(
            onPressed: () => context.read<CounterModel>().increment(),
            child: Icon(Icons.add),
          ),
          // Calls the decrement method fro the counter model
          FloatingActionButton(
            onPressed: () => context.read<CounterModel>().decrement(),
            child: Icon(Icons.remove),
          ),
          // Calls the reset method fro the counter model
          FloatingActionButton(
            onPressed: () => context.read<CounterModel>().reset(),
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
      create:(_,) => CounterModel(),
      child: MaterialApp(
        title: AppStrings.appName,
        home: CounterWidget(),
      ),
    ),
  );
}
