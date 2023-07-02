import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:care_flow/doctor/home/view/widgets/disease_area_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      cacheExtent: 500,
      itemBuilder: (context, index) => diseasesArea[index],
      itemCount: diseasesArea.length,
    );
  }

  List<Widget> diseasesArea = [
    Builder(
      builder: (context) => GestureDetector(onTap: () {
        context.push(Routes.lungRoute);
      } ,child: const DiseaseAreaItem(image: AppImages.lung1, title: "Lung Diseases")),
    ),
  ];
}
