import 'package:care_flow/core/utils/colors.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MaterialButton(onPressed: (){},color: MyColors.primary,child: const Text('Show notifications'),)),
    );
  }
}
