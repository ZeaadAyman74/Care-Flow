import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/patient/responses/models/response_model.dart';
import 'package:care_flow/patient/responses/view/widgets/response_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsesList extends StatelessWidget {
  const ResponsesList({Key? key,required this.responses}) : super(key: key);
final List<ResponseModel>responses;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // responses[index].isRead=true;
            context.push(Routes.responseDetailsRoute,arg: {'response':responses[index]});
            // ReceiveRequestsCubit.get(context).readRequest(requests[index].requestId!);
          },
          child: ResponseItem(response: responses[index],)
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        itemCount: responses.length);
  }
}
