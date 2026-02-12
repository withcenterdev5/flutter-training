import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(
    home: MessageWidget(),
  ));
}


class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  bool _showMessage = false;

  void toggleShowMessage(){
    setState(() {
      _showMessage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              if(_showMessage) Text("Hello Flutter!"),
              ElevatedButton(onPressed: () => toggleShowMessage(), child: Text("tap to show the message"))
            ],
          ),
        ),
      ),
    );
  }
}