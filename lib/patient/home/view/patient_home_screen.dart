import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/layout/view/widgets/disease_item.dart';
import 'package:care_flow/patient/home/models/specialization_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
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
      body: AnimationLimiter(
        child: GridView(
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
                  (index) => AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    columnCount: 2,
                    child:SlideAnimation(
                      horizontalOffset: -100.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                            onTap: () => context.push(Routes.chooseDoctorRoute,
                                arg: {'specialize': specializations[index].title}),
                            child: DiseaseItem(
                              specialization: specializations[index],
                            )),
                      ),
                    ) ,
                  )),
        ),
      ),
    );
  }

  List<SpecializationModel> specializations = [
    SpecializationModel(image: sl<AppImages>().lung, title: 'Lung diseases'),
    SpecializationModel(image: sl<AppImages>().heart, title: 'Cardiology'),
    SpecializationModel(image: sl<AppImages>().bone, title: 'Orthopedic'),
    SpecializationModel(image: sl<AppImages>().brain, title: 'Brain diseases'),
    SpecializationModel(image: sl<AppImages>().eye, title: 'Ophthalmologist'),
    SpecializationModel(image: sl<AppImages>().skin, title: 'Dermatologist'),
    SpecializationModel(image: sl<AppImages>().urologist, title: 'Urologist'),
    SpecializationModel(image: sl<AppImages>().ear, title: 'Otolaryngologies'),
  ];
}
