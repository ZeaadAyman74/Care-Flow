import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/doctor/diagnoses/models/diagnosis_model.dart';
import 'package:care_flow/doctor/diagnoses/view/widgets/diagnosis_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnosesList extends StatelessWidget {
  const DiagnosesList({Key? key,required this.diagnoses}) : super(key: key);
final List<DiagnosisModel>diagnoses;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.push(Routes.diagnosisDetailsRoute,arg: {'diagnosisId':diagnoses[index].diagnosisId});
          },
          child: DiagnosisItem(diagnosis: diagnoses[index]),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        itemCount: diagnoses.length);
  }
}

