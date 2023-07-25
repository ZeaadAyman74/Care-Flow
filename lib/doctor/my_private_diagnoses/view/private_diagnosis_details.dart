import 'package:auto_size_text/auto_size_text.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/private_diagnosis/models/private_diagnosis_model.dart';
import 'package:care_flow/patient/responses/view/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivateDiagnosisDetails extends StatelessWidget {
  const PrivateDiagnosisDetails({Key? key,required this.model}) : super(key: key);
final PrivateDiagnosisModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Private Diagnosis'),
        centerTitle: true,
        elevation: 5,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
        children:  [
          const MyTitle(title: 'Patient Info', icon: Icons.info_outline,),
          SizedBox(height: 10.h,),
          AutoSizeText.rich(
            TextSpan(
                children: [
                  TextSpan(text: 'Name: ',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600
                      ,color: sl<MyColors>().primary)),
                  TextSpan(text:model.name,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500)),
                ]
            ),
            maxLines: 2,
            minFontSize: 18.sp,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5.h,),
          AutoSizeText.rich(
            TextSpan(
                children: [
                  TextSpan(text: 'Age: ',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,color: sl<MyColors>().primary)),
                  TextSpan(text:model.age,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500)),
                ]
            ),
            maxLines: 2,
            minFontSize: 18.sp,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 30.h,),
          Row(
            children: [
               FaIcon( FontAwesomeIcons.virusCovid, color: sl<MyColors>().primary,),
              SizedBox(width: 5.w,),
              AutoSizeText.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: 'COVID-19 Check: ',
                        style: TextStyle(fontSize: 18.sp, color: sl<MyColors>()
                            .primary),
                      ),
                      TextSpan(
                        text: model.result,
                        style: TextStyle(fontSize: 18.sp, color:model.result=='positive'? Colors.red:
                        Colors.green),
                      ),
                    ]
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h,),
          const MyTitle(title: 'Your Notes', icon: Icons.speaker_notes),
          SizedBox(height: 5.h,),
          AutoSizeText(model.notes??'No notes',maxLines: 100,overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}
