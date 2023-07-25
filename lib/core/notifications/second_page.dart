import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
    required this.message
  }) : super(key: key);

  final RemoteMessage message;
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    print('second/////////////////////////////////////////');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.message);
    return Scaffold(
      body: Center(
        child: Text(widget.message.notification!.body!),
      ),
    );
  }
}
