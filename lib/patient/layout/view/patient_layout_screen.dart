import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/layout/business_logic/patient_layout_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        title: const Text('MEDIX-E'),
        centerTitle: true,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) async {
                sl<AppStrings>().uId = null;
                context.pushAndRemove(Routes.chooseRole);
                await sl<CacheHelper>().removeValue(key: 'uId');
                await sl<CacheHelper>().removeValue(key: 'role');
              });
            },
          ),
        ],
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
curve: Curves.easeIn,
            activeColor: sl<MyColors>().primary,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[200]!,
            color: sl<MyColors>().black.withOpacity(.9),
            tabs: [
              GButton(
                iconSize: 20.w,
                gap: 10.h,
                icon: FontAwesomeIcons.house,
                text: 'Home',
              ),
              GButton(
                gap: 10.h,
                iconSize: 20.w,
                icon: FontAwesomeIcons.envelope,
                text: 'Requests',
              ),
              GButton(
                gap: 10.h,
                iconSize: 20.w,
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
