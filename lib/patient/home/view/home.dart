import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/layout/view/widgets/disease_item.dart';
import 'package:care_flow/patient/home/models/specialization_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GridView(
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
          topicsWidgets.length,
              (index) => topicsWidgets[index]
      ),
    );
  }

  List<Widget>topicsWidgets=[
    Builder(
      builder: (context) =>  GestureDetector(
        onTap: () => context.push(Routes.diagnosisRoute),
        child: DiseaseItem(
          specialization: SpecializationModel(image: sl<AppImages>().diagnosis, title: 'Diagnosis'),
        ),
      ),
    ),
    Builder(
      builder: (context) =>  GestureDetector(
        onTap: () => context.push(Routes.medicineRecommenderRoute),
        child: DiseaseItem(
          specialization: SpecializationModel(image: sl<AppImages>().drug, title: 'Medicine Recommender'),
        ),
      ),
    ),
    Builder(
      builder: (context) =>  GestureDetector(
        onTap: () => context.push(Routes.labSpecializationsRoute),
        child: DiseaseItem(
          specialization: SpecializationModel(image: sl<AppImages>().lab, title: 'Lab'),
        ),
      ),
    ),
  ];

}
