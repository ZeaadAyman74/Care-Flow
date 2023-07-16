import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/layout/view/widgets/disease_item.dart';
import 'package:care_flow/patient/home/models/specialization_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AppImages.lung), context);
    precacheImage(const AssetImage(AppImages.heart), context);
    precacheImage(const AssetImage(AppImages.bone), context);
    precacheImage(const AssetImage(AppImages.brain), context);
    precacheImage(const AssetImage(AppImages.eye), context);
    precacheImage(const AssetImage(AppImages.skin), context);
    precacheImage(const AssetImage(AppImages.urologist), context);
    precacheImage(const AssetImage(AppImages.ear), context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis'),
        centerTitle: true,
        elevation: 5,
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
            specializations.length,
                (index) => GestureDetector(
                onTap: () => context.push(Routes.chooseDoctorRoute,
                    arg: {'specialize': specializations[index].title}),
                child: DiseaseItem(
                  specialization: specializations[index],
                ))),
      ),
    );
  }

  List<SpecializationModel> specializations = [
    SpecializationModel(image: AppImages.lung, title: 'Lung diseases'),
    SpecializationModel(image: AppImages.heart, title: 'Cardiology'),
    SpecializationModel(image: AppImages.bone, title: 'Orthopedic'),
    SpecializationModel(image: AppImages.brain, title: 'Brain diseases'),
    SpecializationModel(image: AppImages.eye, title: 'Ophthalmologist'),
    SpecializationModel(image: AppImages.skin, title: 'Dermatologist'),
    SpecializationModel(image: AppImages.urologist, title: 'Urologist'),
    SpecializationModel(image: AppImages.ear, title: 'Otolaryngologies'),
  ];
}
