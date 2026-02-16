import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeProvider extends ChangeNotifier {
  String _size = 'Small';
  double _price = 3.50;

  String get size => _size;
  double get price => _price;

  void updateSize(String newSize) {
    _size = newSize;
    if (newSize == 'Large') {
      _price = 5.50;
    } else {
      _price = 3.50;
    }
    notifyListeners();
  }
}

class PriceDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
              // by using Consumer widget we prevent the whole outer build() from rebuilding everything inside it, including the elevated button itself. It is unecessary to build the button
              // We only want the Text widget to rebuild that's why we wrapped it inside the Consumer widget!!!
              //Consumer<CoffeeProvider>(builder: (context, value, child) => Text(value.price.toString())),
              // by using Selector wiget we prevent unecessary build of this widget by only listening to one property!
              Selector<CoffeeProvider, double>(
                selector: (context, model) => model.price,
                child: const Icon(Icons.coffee),
                builder: (context, value, child) => Row(
                  mainAxisAlignment: .center,
                  children: [
                    child!,
                    Text(value.toString()),
                  ],
                ), 
              ),
              ElevatedButton(
                child: Text('Go Large!'),
                onPressed: () {
                  
                },
            )
          ],
        ),
      ),
    );
  }
}


void main(){
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CoffeeProvider(),)], 
      child: MaterialApp(
        home: PriceDisplay()
      ),)
  );
}
