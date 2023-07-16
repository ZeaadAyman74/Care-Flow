import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/layout/view/widgets/disease_item.dart';
import 'package:care_flow/patient/home/models/specialization_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabLungDiseases extends StatelessWidget {
  const LabLungDiseases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text(
          'Lung diseases Check',
        ),
        centerTitle: true,
      ),
      body: GridView(
        cacheExtent: 500,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0.w,
          crossAxisSpacing: 12.0.w,
          childAspectRatio: 1.05,
        ),
        children: List.generate(
            1,
                (index) => GestureDetector(
                onTap: () => context.push(Routes.labCheckRoute),
                child: DiseaseItem(
                  specialization: SpecializationModel(
                      image: AppImages.corona, title: 'COVID-19'),
                ))),
      ),
    );
  }
}
