import 'package:care_flow/choose_role/business_logic/choose_role_cubit.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            bottom: 20.h,
            top: context.height * .18,
            left: 10.w,
            right: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Who are you ?',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: MyColors.black),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'who do you want to register as ?',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              SizedBox(
                height: context.height * .15,
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
                    builder: (context, state) => CharacterItem(
                      isChecked: ChooseRoleCubit.get(context).isPatient,
                      image: AppImages.patient,
                      role: 'Patient',
                      onTap: () {
                        if (ChooseRoleCubit.get(context).isDoctor) {
                          ChooseRoleCubit.get(context).changeRole();
                        }
                      },
                    ),
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                      child: BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
                    builder: (context, state) => CharacterItem(
                      isChecked: ChooseRoleCubit.get(context).isDoctor,
                      image: AppImages.doctor,
                      role: 'Doctor',
                      onTap: () {
                        if (ChooseRoleCubit.get(context).isPatient) {
                          ChooseRoleCubit.get(context).changeRole();
                        }
                      },
                    ),
                  )),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  child: MaterialButton(
                    height: 40.h,
                    animationDuration: const Duration(seconds: 1),
                    onPressed: () {
                      if (ChooseRoleCubit.get(context).isDoctor) {
                        context.push(Routes.loginRoute);
                      } else {
                        context.push(Routes.patientLoginRoute);
                      }
                    },
                    color: MyColors.primary,
                    child: Text('Continue',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterItem extends StatefulWidget {
  const CharacterItem(
      {Key? key,
      required this.image,
      required this.role,
      required this.onTap,
      required this.isChecked})
      : super(key: key);

  final String role;
  final String image;
  final Function()? onTap;
  final bool isChecked;

  @override
  State<CharacterItem> createState() => _CharacterItemState();
}

class _CharacterItemState extends State<CharacterItem> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AppImages.patient), context);
    precacheImage(const AssetImage(AppImages.doctor), context);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Material(
        elevation: 3,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        child: ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.isChecked ? MyColors.primary : Colors.grey[200]!,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      children: [
                        ClipOval(
                            child: Image.asset(
                          widget.image,
                          height: 100.w,
                          width: 100.w,
                        )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          widget.role,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                height: 25.w,
                width: 25.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.isChecked ? Colors.green : Colors.grey[400]),
                child: widget.isChecked
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
