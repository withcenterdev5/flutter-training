import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserProvider extends ChangeNotifier {
  bool _isPremium = false;
  bool get isPremium => _isPremium;

  void togglePremium(){
    _isPremium = !_isPremium;
    notifyListeners();
  }
}


class CoffeeProvider extends ChangeNotifier {
  String _size = 'Small';
  double _price = 3.50;
  bool isPremiumUser;

  CoffeeProvider({required this.isPremiumUser});

  String get size => _size;
  double get price => isPremiumUser ? 2.50 : _price;

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
                builder: (context, value, child) => Column(
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
                  context.read<CoffeeProvider>().updateSize("Large");
                },
              ), 
              PremiumToggle()
              
          ],
        ),
      ),
    );
  }
}

class PremiumToggle extends StatelessWidget {
  const PremiumToggle({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. WATCH the UserProvider to see if we are currently premium
    final isPremium = context.watch<UserProvider>().isPremium;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPremium ? Colors.amber : Colors.grey,
      ),
      child: Text(isPremium ? 'Premium Active' : 'Go Premium'),
      onPressed: () {
        // TODO: Access the UserProvider and call the function to toggle status.
        // Hint: We are inside an onPressed, so use the "one-time access" method.
        
        // YOUR CODE HERE
        context.read<UserProvider>().togglePremium();
      },
    );
  }
}



void main(){
  runApp(
   MultiProvider(
      providers: [
        // Create the source of truth
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Glue the UserProvider to the CoffeeProvider
        ChangeNotifierProxyProvider<UserProvider, CoffeeProvider>(
          // 1. Create the initial object
          create: (_) => CoffeeProvider(isPremiumUser: false),
          // 2. Update it when UserProvider changes
          update: (context, userProvider, coffeeProvider) {
            // We update the existing coffeeProvider rather than creating a new one
            // This preserves the 'size' state (Small/Large)
            coffeeProvider!.isPremiumUser = userProvider.isPremium; 
            return coffeeProvider;                              
          },
        ),
      ],
      child: MaterialApp(home: PriceDisplay()),
    )
  );
}
