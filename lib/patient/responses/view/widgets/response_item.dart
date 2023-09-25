import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/patient/responses/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponseItem extends StatelessWidget {
  const ResponseItem({Key? key,required this.response}) : super(key: key);
final ResponseModel response;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(
          color:sl<MyColors>().primary,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          response.doctorImage==null?
          CircleAvatar(
            radius: 40.r,
            backgroundImage:   AssetImage(sl<AppImages>().doctor),
          ):
          CircleAvatar(
            radius: 40.r,
            backgroundImage:  CachedNetworkImageProvider(response.doctorImage!),
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
                  'From Dr/${response.doctorName}',
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
    );
  }
}
