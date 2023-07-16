import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/patient/responses/view/widgets/title.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SentRequestDetails extends StatelessWidget {
  const SentRequestDetails({Key? key,required this.request}) : super(key: key);
final RequestModel request;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('to Dr/ ${request.doctorName}'),
      centerTitle: true,
        elevation: 5,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
        children: [
          const MyTitle(title: 'complaint:', icon: FontAwesomeIcons.comment),
          SizedBox(height: 10.h,),
          AutoSizeText(request.notes),
          SizedBox(height: 20.h,),
          const MyTitle(title: 'Previous diseases:', icon: FontAwesomeIcons.disease),
          SizedBox(height: 10.h,),
          AutoSizeText(request.prevDiseases),
          SizedBox(height: 30.h,),
          Container(
            height: 200.w,
            width: 200.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r))
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.network(request.xrayImage, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
