import 'package:care_flow/core/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

abstract class MyTheme {
  static ThemeData lightTheme() => ThemeData(
    primarySwatch: sl<MyColors>().getMaterialColor(),
    primaryColor: sl<MyColors>().primary,
    scaffoldBackgroundColor:sl<MyColors>().white,
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 16.sp, color:sl<MyColors>().black, fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 20.sp, color:sl<MyColors>().black, fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 24.sp, color:sl<MyColors>().black, fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
          fontSize: 22.sp,
          color:sl<MyColors>().black,
          fontWeight: FontWeight.w700
      ),
      titleLarge: TextStyle(
          fontSize: 24.sp,
          color:sl<MyColors>().black,
          fontWeight: FontWeight.w700
      ),
      displaySmall: TextStyle(
        color:sl<MyColors>().black,
        fontSize: 14.sp,
      ),
    ),
  );

  static ThemeData darkTheme() => ThemeData.dark();
}

