import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/layout/view/widgets/disease_item.dart';
import 'package:care_flow/patient/home/models/specialization_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabSpecializationsScreen extends StatefulWidget {
  const LabSpecializationsScreen({Key? key}) : super(key: key);

  @override
  State<LabSpecializationsScreen> createState() => _LabSpecializationsScreenState();
}

class _LabSpecializationsScreenState extends State<LabSpecializationsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage( AssetImage(sl<AppImages>().lung), context);
    precacheImage( AssetImage(sl<AppImages>().heart), context);
    precacheImage( AssetImage(sl<AppImages>().bone), context);
    precacheImage( AssetImage(sl<AppImages>().brain), context);
    precacheImage( AssetImage(sl<AppImages>().eye), context);
    precacheImage( AssetImage(sl<AppImages>().skin), context);
    precacheImage( AssetImage(sl<AppImages>().urologist), context);
    precacheImage( AssetImage(sl<AppImages>().ear), context);

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
                (index) => specializations[index]),
      ),
    );
  }

  List<Widget> specializations = [
    Builder(
      builder: (context) {
        return GestureDetector(
            onTap: () => context.push(Routes.labLungDiseases,),
            child: DiseaseItem(
              specialization: SpecializationModel(image: sl<AppImages>().lung, title: 'Lung diseases'),
            ));
      }
    ),
    GestureDetector(
        onTap: () {},
        child: DiseaseItem(
          specialization:     SpecializationModel(image: sl<AppImages>().heart, title: 'Cardiology'),
        )),
    GestureDetector(
        onTap: () {},
        child: DiseaseItem(
          specialization:    SpecializationModel(image: sl<AppImages>().bone, title: 'Orthopedic'),
        )),
    GestureDetector(
        onTap: () {},
        child: DiseaseItem(
          specialization: SpecializationModel(image: sl<AppImages>().brain, title: 'Brain diseases'),
        )),
    GestureDetector(
        onTap: (){},
        child: DiseaseItem(
          specialization:     SpecializationModel(image: sl<AppImages>().eye, title: 'Ophthalmologist'),
        )),
    GestureDetector(
        onTap: (){},
        child: DiseaseItem(
          specialization:  SpecializationModel(image: sl<AppImages>().skin, title: 'Dermatologist'),
        )),
    GestureDetector(
        onTap: (){},
        child: DiseaseItem(
          specialization: SpecializationModel(image: sl<AppImages>().urologist, title: 'Urologist'),
        )),
    GestureDetector(
        onTap: (){},
        child: DiseaseItem(
          specialization:SpecializationModel(image: sl<AppImages>().ear, title: 'Otolaryngologies'),
        )),


  ];
}
