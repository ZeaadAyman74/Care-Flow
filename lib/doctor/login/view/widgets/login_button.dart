import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key,
      required this.txt,
      required this.radius,
      required this.function,
      required this.background,
      required this.width,
      required this.foreColor})
      : super(key: key);
  final double width;
  final Color background ;
  final Color foreColor;
  final String txt;
  final void Function() function;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
    bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          txt,
          style: TextStyle(fontSize: 17.sp, color: foreColor),
        ),
      ),
    );
  }
}
