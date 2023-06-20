import 'package:care_flow/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiseaseItem extends StatefulWidget {
  const DiseaseItem({
    Key? key,
  }) : super(key: key);

// final String title;
// final String image;

  @override
  State<DiseaseItem> createState() => _DiseaseItemState();
}

class _DiseaseItemState extends State<DiseaseItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(AppImages.corona),
            SizedBox(height: 8.h),
            const Text('COVID-19'),
          ],
        ),
      ),
    );
  }
}
