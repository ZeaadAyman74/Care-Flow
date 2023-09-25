import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/doctor/receive_request/business_logic/receive_request_cubit/receive_requests_cubit.dart';
import 'package:care_flow/doctor/receive_request/models/request_model.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RequestsList extends StatelessWidget {
  const RequestsList(
      {Key? key, required this.requests, required this.scrollController})
      : super(key: key);
  final List<RequestModel> requests;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: SlideAnimation(
                  verticalOffset: 100.0,
                  child: FadeInAnimation(
                      child: GestureDetector(
                    onTap: () {
                      requests[index].isRead = true;
                      context.push(Routes.requestDetailsRoute,
                          arg: {'id': requests[index].id});
                      ReceiveRequestsCubit.get(context)
                          .readRequest(requests[index].id);
                    },
                    child: RequestItem(
                      request: requests[index],
                    ),
                  )),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
          itemCount: requests.length),
    );
  }
}
