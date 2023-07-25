import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key,required this.text}) : super(key: key);
final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(sl<AppImages>().empty,),
         Text(text,style:  TextStyle(fontSize: 22,color: sl<MyColors>().primary),)
      ],
    );;
  }
}
