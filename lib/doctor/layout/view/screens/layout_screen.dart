import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/layout/business_logic/home_layout_cubit/home_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        title: const Text('MEDIX-E'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
          builder: (context, state) => HomeLayoutCubit.get(context)
              .views
              .elementAt(HomeLayoutCubit.get(context).selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
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
            gap: 5,
            activeColor: sl<MyColors>().primary,
            iconSize: 22,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: sl<MyColors>().black.withOpacity(.5),
            tabs: [
              GButton(
                gap: 10.h,
                icon: FontAwesomeIcons.house,
                text: 'Home',
              ),
              GButton(
                gap: 10.h,
                icon: Icons.question_mark,
                text: 'Requests',
              ),
              GButton(
                gap: 10.h,
                icon: Icons.question_answer,
                text: 'Responses',
              ),
            ],
            selectedIndex: HomeLayoutCubit.get(context).selectedIndex,
            onTabChange: (index) {
              HomeLayoutCubit.get(context).changeView(index);
            },
          ),
        ),
      ),
    );
  }
}
