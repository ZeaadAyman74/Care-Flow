import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/prediction/view/widgets/common_buttons.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveResultDialog extends StatelessWidget {
  const SaveResultDialog({Key? key, required this.result,required this.request}) : super(key: key);
  final String result;
  final RequestModel request;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      shadowColor: Colors.black,
      contentPadding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'The Result is: ',
                    style: TextStyle(
                        color: sl<MyColors>().black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: result,
                    style: TextStyle(
                        color:
                        result == 'positive' ? Colors.red : Colors.green,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600))
              ])),
          SizedBox(height: 40.h,),
          CommonButtons(textLabel: 'Continue', textColor: Colors.white, backgroundColor: sl<MyColors>().primary, onTap: (){
            context.pop();
           context.push(Routes.sendDiagnosisRoute,arg: {'request':request,'coronaResult':result});
          }),
          SizedBox(height: 10.h,),
          CommonButtons(textLabel: 'Back', textColor: Colors.white, backgroundColor: Colors.black, onTap: () async {
            context.pop();
          }),
        ],
      ),
    );
  }
}
