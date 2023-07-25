import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:care_flow/doctor/layout/business_logic/new_layout_cubit/new_layout_cubit.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_index.dart';
import 'package:care_flow/doctor/layout/view/widgets/drawer_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewLayout extends StatefulWidget {
  const NewLayout({Key? key}) : super(key: key);

  @override
  State<NewLayout> createState() => _NewLayoutState();
}

class _NewLayoutState extends State<NewLayout> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        color: sl<MyColors>().nearlyWhite,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              backgroundColor: sl<MyColors>().nearlyWhite,
              body: BlocBuilder<NewLayoutCubit, NewLayoutState>(
                  builder: ((context, state) {
                    return DrawerUserController(
                      screenIndex: NewLayoutCubit.get(context).currentDrawerIndex,
                      drawerWidth: context.width * 0.75,
                      onDrawerCall: (DrawerIndex drawerIndex) => NewLayoutCubit.get(context).changeDrawerIndex(drawerIndex),
                      screenView:NewLayoutCubit.get(context).screenView,
                    );
                  }))),
        ));
  }
}
