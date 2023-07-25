import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/register/models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({Key? key, required this.doctor}) : super(key: key);
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.sendRequestRoute,
          arg: {'doctorName': doctor.name, 'doctorId': doctor.uId,'doctorSpecialize':doctor.specialize}),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundImage:  AssetImage(sl<AppImages>().doctor),
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
                    doctor.name,
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AutoSizeText(
                    doctor.about,
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
