import 'package:counter/constants/app_colors.dart';
import 'package:counter/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter/models/counter_model.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Column(
        children: [
          // Rebuild the text widget to display the updated state
          Consumer<CounterModel>(
            builder:(_,model,_,) => Text("Counter: ${model.count}", style: TextStyle(color: AppColors.primaryColor),),
          ),
        ],
      ),
      //Buttons for incrementing and decrmenting the count value from the count model
      floatingActionButton: Column(
        spacing: 20.0,
        mainAxisAlignment: .end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterModel>().increment(),
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => context.read<CounterModel>().decrement(),
            child: Icon(Icons.remove),
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
