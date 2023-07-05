import 'package:care_flow/doctor/register/models/register_model.dart';
import 'package:care_flow/patient/choose_doctor/view/widgets/doctor_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({Key? key, required this.doctors}) : super(key: key);
  final List<DoctorModel> doctors;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 5.h,bottom: 5.h),
        itemBuilder: (context, index) => DoctorItem(doctor: doctors[index]),
        separatorBuilder: (context, index) => SizedBox(
              height: 10.h,
            ),
        itemCount: doctors.length);
  }
}
