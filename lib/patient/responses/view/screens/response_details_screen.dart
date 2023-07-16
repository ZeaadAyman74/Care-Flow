import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/info_part.dart';
import 'package:care_flow/doctor/send_diagnosis/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:care_flow/patient/responses/view/widgets/title.dart';

class ResponseDetailsScreen extends StatelessWidget {
  const ResponseDetailsScreen({Key? key, required this.response})
      : super(key: key);
  final ResponseModel response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis'),
        centerTitle: true,
        elevation: 5,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        children: [
          InfoPart(
              name: response.patientName,
              age: response.patientAge,
              email: response.patientEmail,
              phone: response.patientPhone),
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.primary),
              borderRadius: BorderRadius.all(Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('Your Request',style: TextStyle(fontSize: 24.sp,color: MyColors.primary,fontWeight: FontWeight.w700),),
                ),
                SizedBox(height: 20.h,),
                const MyTitle(title: 'complaint:', icon: FontAwesomeIcons.comment),
                SizedBox(height: 10.h,),
                AutoSizeText(response.patientNotes),
                SizedBox(height: 20.h,),
                const MyTitle(title: 'Previous diseases:', icon: FontAwesomeIcons.disease),
                SizedBox(height: 10.h,),
                AutoSizeText(response.prevDiseases),
                SizedBox(height: 30.h,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200.w,
                    width: 200.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(response.xray, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h,),
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.primary),
              borderRadius: BorderRadius.all(Radius.circular(20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('Doctor Diagnosis',style: TextStyle(fontSize: 24.sp,color: MyColors.primary,fontWeight: FontWeight.w700),),
                ),
                SizedBox(height: 20.h,),
                const MyTitle(
                  icon: FontAwesomeIcons.check,
                  title: 'Checks',
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.virusCovid, color: MyColors.primary,),
                    SizedBox(width: 5.w,),
                    AutoSizeText.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                              text: 'COVID-19 Check:',
                              style: TextStyle(fontSize: 18.sp, color: MyColors
                                  .primary),
                            ),
                            TextSpan(
                              text: response.coronaCheck,
                              style: TextStyle(fontSize: 18.sp, color:response.coronaCheck=='positive'? Colors.red:
                              Colors.green),
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                const MyTitle(title: 'Tips',icon: Icons.tips_and_updates),
                AutoSizeText(response.tips,style: TextStyle(fontSize: 18.sp),maxLines: 100),
                SizedBox(height: 20.h,),
                const MyTitle(title: 'Medicine',icon: Icons.medical_information_outlined),
                AutoSizeText(response.medicine,style: TextStyle(fontSize: 18.sp),maxLines: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

