import 'package:care_flow/core/cache_helper.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/register/models/register_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(BuildContext context)=>BlocProvider.of<UserCubit>(context);

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
    await FirebaseMessaging.instance.deleteToken();
    await sl<CacheHelper>().removeValue(key: 'uId');
    await sl<CacheHelper>().removeValue(key: 'role');
  }
}
