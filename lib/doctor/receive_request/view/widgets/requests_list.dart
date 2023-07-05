import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/request_item.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({Key? key, required this.requests}) : super(key: key);
  final List<RequestModel> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            requests[index].read=true;
            context.push(Routes.requestDetailsRoute,arg: {'request':requests[index]});
            ReceiveRequestsCubit.get(context).readRequest(requests[index].requestId!);
          },
          child: RequestItem(
                request: requests[index],
              ),
        ),
        separatorBuilder: (context, index) => SizedBox(
              height: 10.h,
            ),
        itemCount: requests.length);
  }
}
