import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoPart extends StatelessWidget {
  const InfoPart({Key? key,required this.name,required this.email,required this.phone,required this.age}) : super(key: key);
final String name;
final int age;
final String phone;
final String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            AutoSizeText.rich(
              TextSpan(
                  children: [
                    TextSpan(text: 'Name: ',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600)),
                    TextSpan(text:name,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500)),
                  ]
              ),
              maxLines: 2,
              minFontSize: 18.sp,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5.h,),
            AutoSizeText.rich(
              TextSpan(
                  children: [
                    TextSpan(text: 'Email: ',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600)),
                    TextSpan(text:email,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500)),
                  ]
              ),
              maxLines: 2,
              minFontSize: 18.sp,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5.h,),
            AutoSizeText.rich(
              TextSpan(
                  children: [
                    TextSpan(text: 'Age: ',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600)),
                    TextSpan(text:age.toString(),style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500)),
                  ]
              ),
              maxLines: 2,
              minFontSize: 18.sp,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5.h,),
            AutoSizeText.rich(
              TextSpan(
                  children: [
                    TextSpan(text: 'Phone: ',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600)),
                    TextSpan(text:phone,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500)),
                  ]
              ),
              maxLines: 2,
              minFontSize: 18.sp,
              textAlign: TextAlign.start,
            ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),child: const DottedLine()),
      ],
    );
  }
}
