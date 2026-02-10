import 'package:flutter/material.dart';

void
main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
} 

class HomeScreen
    extends
        StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<
    HomeScreen
  >
  createState() => _HomeScreenState();
}

class _HomeScreenState
    extends
        State<
          HomeScreen
        > {
  final textEditingController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Text Controller",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        enableSuggestions: false,
        decoration: InputDecoration(
          hintText: 'Type something...',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (
                  context,
                ) => AlertDialog(
                  title: Text(
                    "Your Input",
                  ),
                  content: Text(
                    textEditingController.text,
                  ),
                ),
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
