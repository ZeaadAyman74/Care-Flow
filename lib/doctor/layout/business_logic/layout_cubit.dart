import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/core/utils/app_extensions.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/diagnoses/view/diagnoses_screen.dart';
import 'package:care_flow/doctor/home/view/screens/home.dart';
import 'package:care_flow/doctor/receive_request/view/screens/requests_screen.dart';
import 'package:care_flow/doctor/register/models/register_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(BuildContext context) =>
      BlocProvider.of<LayoutCubit>(context);

  int selectedIndex = 0;
  List<Widget> views = [
    const HomeScreen(),
    const RequestsScreen(),
    const DiagnosesScreen(),
    // Builder(
    //   builder: (context) => Center(
    //     child: TextButton(
    //       child: const Text('Logout'),
    //       onPressed: () async {
    //         await FirebaseAuth.instance.signOut().then((value) async {
    //           context.pushAndRemove(Routes.chooseRole);
    //           AppStrings.uId = null;
    //           LayoutCubit.get(context).currentDoctor=null;
    //           await CacheHelper.removeValue(key: 'uId');
    //           await CacheHelper.removeValue(key: 'role');
    //         });
    //       },
    //     ),
    //   ),
    // ),
  ];

  void changeView(int index) {
    selectedIndex = index;
    emit(ChangeScreen());
  }

  DoctorModel? currentDoctor;
  Future<void>getCurrentDoctor()async{
    try{
      var userData=await FirebaseFirestore.instance.collection('doctors').doc(AppStrings.uId).get();
      currentDoctor=DoctorModel.fromJson(userData.data()!);
    }catch(error){
      if(kDebugMode){
        print(error.toString());
      }
    }

  }
}
