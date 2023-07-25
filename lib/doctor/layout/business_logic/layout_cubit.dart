import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/di_container.dart';
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
  ];

  void changeView(int index) {
    selectedIndex = index;
    emit(ChangeScreen());
  }

  DoctorModel? currentDoctor;

  Future<void> getCurrentDoctor() async {
    try {
      var userData = await FirebaseFirestore.instance.collection('doctors').doc(
          sl<AppStrings>().uId).get();
      currentDoctor = DoctorModel.fromJson(userData.data()!);
      emit(GetCurrentDoctor());
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<void> doctorLogout() async {
    await FirebaseAuth.instance.signOut();
    sl<AppStrings>().uId = null;
    await sl<CacheHelper>().removeValue(key: 'uId');
    await sl<CacheHelper>().removeValue(key: 'role');
  }
}
