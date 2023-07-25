import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiveRequestsCubit, ReceiveRequestsState>(
      buildWhen: (previous, current) =>
          current is ReadRequest || current is MarkFinishSuccess,
      builder: (context, state) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: request.read ? Colors.grey : sl<MyColors>().primary,
            width: request.read ? 1 : 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundImage:  AssetImage(sl<AppImages>().patient),
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
                    'Medical Consultation',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AutoSizeText(
                    'Tab to see details',
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
            ),
            request.finished
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
