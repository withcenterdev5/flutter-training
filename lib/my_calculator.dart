import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  StringBuffer displayBuffer = .new("0");

  void append(String text) {
    setState(() {
      displayBuffer.write(text);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: const Color.fromARGB(255, 42, 40, 39),
          child: Column(
            children: [
              // Display Text 
              Row(
                children: [
                  Text(displayBuffer.toString(), style: TextStyle(color: const Color.fromARGB(255, 221, 215, 215), fontSize: 70.0))
                ],
              ),
              // First row buttons AC, +/-, %, /
             
              // Second row buttons 7, 8, 9, X
              Row(),
              // Third row buttons 4, 5, 6, -
              Row(),
              // Fourth row buttons 1, 2, 3, +
              Row(),
              // Last row buttons 00, 0, ., =
              Row(),
            ],
          ),
        ),
      )
    );
  }
}

class ButtonRow extends StatelessWidget { 
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                 //CalculatorButton(text: "AC", backgroundColor: )
                ],
              );
  }
}

class CalculatorButton extends StatelessWidget {
  String text;
  Color backgroundColor;
  Color foregroundColor = Colors.white;
  OutlinedBorder shape = CircleBorder();
  double fontSize = 20.0;
  double padding = 20.0;

  CalculatorButton({super.key, required this.text, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton( 
                    style: ElevatedButton.styleFrom(
                      // .fromARGB(255, 118, 117, 117),
                      backgroundColor: backgroundColor,
                      foregroundColor: foregroundColor,
                      shape: shape,
                      padding: EdgeInsets.all(padding)
                    ),
                    onPressed: () {}, 
                    child: Text(text, style: TextStyle(fontSize: fontSize),)
                  );
  }
}