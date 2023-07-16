import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/patient/requests/view/widgets/sent_request_item.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SentRequestsList extends StatelessWidget {
  const SentRequestsList({Key? key,required this.requests}) : super(key: key);
  final List<RequestModel> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            context.push(Routes.sentRequestDetailsRoute,arg: {'request':requests[index]});
          },
          child: SentRequestItem(
            request: requests[index],
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        itemCount: requests.length);
  }
}
