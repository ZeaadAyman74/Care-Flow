import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/private_diagnosis/models/private_diagnosis_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivateDiagnosisItem extends StatelessWidget {
  const PrivateDiagnosisItem({Key? key,required this.model}) : super(key: key);
final PrivateDiagnosisModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.privateDiagnosisRoute,arg: {'model':model}),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(
            color:sl<MyColors>().primary,
            width:1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundImage: AssetImage(sl<AppImages>().diagnosisIcon),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient/${model.name??'No name'}',
                    style:
                    TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AutoSizeText(
                    'Tab to see the diagnosis',
                    maxLines: 100,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxFontSize: 18.sp,
                    minFontSize: 18.sp,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
