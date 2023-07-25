import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/doctor/my_private_diagnoses/view/widgets/private_diagnosis_item.dart';
import 'package:care_flow/doctor/private_diagnosis/models/private_diagnosis_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivateDiagnosesList extends StatelessWidget {
  const PrivateDiagnosesList({Key? key,required this.diagnoses}) : super(key: key);
  final List<PrivateDiagnosisModel>diagnoses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.push(Routes.diagnosisDetailsRoute,arg: {'response':diagnoses[index]});
          },
          child: PrivateDiagnosisItem(model: diagnoses[index]),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        itemCount: diagnoses.length);
  }
}
