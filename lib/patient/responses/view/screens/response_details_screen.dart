import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/receive_request/view/widgets/info_part.dart';
import 'package:care_flow/doctor/send_diagnosis/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          const Title(
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
          const Title(title: 'Tips',icon: Icons.tips_and_updates),
          AutoSizeText(response.tips,style: TextStyle(fontSize: 18.sp),maxLines: 100),
          SizedBox(height: 20.h,),
          const Title(title: 'Medicine',icon: Icons.medical_information_outlined),
          AutoSizeText(response.medicine,style: TextStyle(fontSize: 18.sp),maxLines: 100),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key, required this.title, required this.icon})
      : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         FaIcon(
          icon,
          color: MyColors.primary,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          title,
          style: TextStyle(color: MyColors.primary, fontSize: 22.sp),
        )
      ],
    );
  }
}
