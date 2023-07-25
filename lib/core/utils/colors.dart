  import 'package:flutter/material.dart';
class MyColors {
  const MyColors();
   final Color primary=const Color(0xff0997b1);
   final Color white=const Color(0xffFFFFFF);
   final black=const Color(0xff000000);
   final Color grey =  const Color(0xffD9D9D9);
   final Color backGroundGrey=const Color(0xffEFEFEF);
   final Color hintColor = const Color(0xFF707070);
   final Color notWhite = const Color(0xFFEDF0F2);
   final Color nearlyWhite = const Color(0xFFFEFEFE);
   final Color nearlyBlack = const Color(0xFF213333);


    MaterialColor getMaterialColor(){
      return MaterialColor(const Color(0xff0997b1).value,  <int,Color>{
        50:primary ,
        100:primary,
        200:primary,
        300:primary,
        400:primary,
        500:primary,
        600:primary,
        700:primary,
        800:primary,
        900:primary,
      });
   }

}
//E4FD20