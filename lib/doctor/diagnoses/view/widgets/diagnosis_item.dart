import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/diagnoses/models/diagnosis_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnosisItem extends StatelessWidget {
  const DiagnosisItem({Key? key,required this.diagnosis}) : super(key: key);
final DiagnosisModel diagnosis;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(
          color:Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: AssetImage(sl<AppImages>().doctor),
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
                  'To: ${diagnosis.patientName}',
                  style:
                  TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
                AutoSizeText(
                  'Tab to see details',
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  // maxFontSize: 18.sp,
                  // minFontSize: 24.sp,
                  style: TextStyle(
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
