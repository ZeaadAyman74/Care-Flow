import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/patient/layout/business_logic/patient_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PatientLayoutScreen extends StatefulWidget {
  const PatientLayoutScreen({Key? key}) : super(key: key);

  @override
  State<PatientLayoutScreen> createState() => _PatientLayoutScreenState();
}

class _PatientLayoutScreenState extends State<PatientLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        title: const Text('Care Flow'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<PatientLayoutCubit, PatientLayoutState>(
          builder: (context, state) => PatientLayoutCubit.get(context)
              .views
              .elementAt(PatientLayoutCubit.get(context).selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.h),
          child: GNav(
            
            rippleColor: Colors.grey[300]!,
            gap: 3,
            activeColor: MyColors.primary,
            iconSize: 22,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: MyColors.black.withOpacity(.5),
            tabs: const [
              GButton(
                icon: FontAwesomeIcons.house,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.envelope,
                text: 'Requests',
              ),
              GButton(
                icon: FontAwesomeIcons.message,
                text: 'Responses',
              ),
            ],
            selectedIndex: PatientLayoutCubit.get(context).selectedIndex,
            onTabChange: (index) {
              PatientLayoutCubit.get(context).changeView(index);
            },
          ),
        ),
      ),
    );
  }
}
