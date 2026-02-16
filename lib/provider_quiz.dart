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

    var coffee = context.watch<CoffeeProvider>();


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(coffee.price.toString()),
            ElevatedButton(
              child: Text('Go Large!'),
              onPressed: () {
                // TODO: Use the context to call updateSize('Large') 
                // Hint: Do we need the button itself to "watch" the changes?
                // Your code here
                context.read<CoffeeProvider>().updateSize("Large");
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
