  import 'package:flutter/material.dart';
class MyColors {
  static const Color primary=Color(0xff0997b1);
  static const Color white=Color(0xffFFFFFF);
  static const black=Color(0xff000000);
  static const Color grey =  Color(0xffD9D9D9);
  static const Color backGroundGrey=Color(0xffEFEFEF);

  static  MaterialColor primarySwatch= MaterialColor(const Color(0xff0997b1).value, const <int,Color>{
    50:MyColors.primary ,
    100:MyColors.primary,
    200:MyColors.primary,
    300:MyColors.primary,
    400:MyColors.primary,
    500:MyColors.primary,
    600:MyColors.primary,
    700:MyColors.primary,
    800:MyColors.primary,
    900:MyColors.primary,

  });
}
//E4FD20