

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModel extends ChangeNotifier {
  bool isLightMode = true;

  void toggleTheme(){
    isLightMode = !isLightMode;
    notifyListeners();
  }
}


void main(){
  runApp(ChangeNotifierProvider(create: (context) => ThemeModel(), child: MaterialApp(home: Home(),),));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Toggler using Provider"),
      ),
      body: Consumer<ThemeModel>(builder: (context, value, child) => GestureDetector(
        onTap: () => value.toggleTheme(),
        child: Container(
          color: value.isLightMode ? Colors.white : Colors.black,
        ),
      )),
    );
  }
}