import 'package:care_flow/patient/home/models/specialization_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiseaseItem extends StatefulWidget {
  const DiseaseItem({
    Key? key,
   required this.specialization,
  }) : super(key: key);

final SpecializationModel specialization;

  @override
  State<DiseaseItem> createState() => _DiseaseItemState();
}

class _DiseaseItemState extends State<DiseaseItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
      elevation: 5,
      child: LayoutBuilder(
        builder: (context,constraints) =>Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(widget.specialization.image,height:constraints.maxHeight*.75,width: constraints.maxWidth, fit: BoxFit.fill,),
               Text(widget.specialization.title),
            ],
          ),
        ),
      ),
    );
  }
}
