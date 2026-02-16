import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider extends ChangeNotifier {
  int count;
  CounterProvider({this.count = 0});

  void increment(){
    count++;
    notifyListeners();
  }

  void decrement(){
    count--;
    notifyListeners();
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center, 
            children: [
              Consumer<CounterProvider>(builder: (context, value, child) => Text(value.count.toString()),),
              Selector<CounterProvider, int>(
                selector: (context, counterModel) => counterModel.count,
                builder: (context, value, child) => Text(value.toString()), 
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterProvider>().increment(), 
          child: const Icon(Icons.plus_one),
        ),
      ),
    );
  }
}

void main(){
  runApp(
    MultiProvider(
      providers: [ ChangeNotifierProvider(create: (context) => CounterProvider() )],
      child: MyApp(),
    )
  );
}