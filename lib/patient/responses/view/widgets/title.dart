import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({Key? key, required this.title, required this.icon})
      : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          icon,
          color: sl<MyColors>().primary,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          title,
          style: TextStyle(color: sl<MyColors>().primary, fontSize: 22.sp),
        )
      ],
    );
  }
}
