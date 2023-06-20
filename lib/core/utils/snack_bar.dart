import 'package:care_flow/core/utils/my_inums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';


abstract class AppFunctions {
 static void showMySnackBar(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message,style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20,color: Colors.white),),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        ));
  }

 static void showToast({required String message,required ToastStates state})=>Fluttertoast.showToast(
     msg: message,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 2,
     backgroundColor: _chooseToastColor(state),
     textColor: Colors.white,
     fontSize: 16.sp);

static Color _chooseToastColor(ToastStates state){
  switch(state){
    case ToastStates.error:
      return Colors.red;
    case ToastStates.success:
      return Colors.green;
    case ToastStates.warning:
      return Colors.amber;
  }
}
}
