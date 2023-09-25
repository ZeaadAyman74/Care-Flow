import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/fcm/fcm.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isVisible = true;
  var visibleIcon = Icons.visibility;

  dynamic changePassVisibility() {
    if (isVisible == true) {
      visibleIcon = Icons.visibility_off;
      isVisible = false;
      emit(ChangePassVisibility());
    } else {
      visibleIcon = Icons.visibility;
      isVisible = true;
      emit(ChangePassVisibility());
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((loginUser) async {
        var userData = await FirebaseFirestore.instance
            .collection('doctors')
            .doc(loginUser.user!.uid)
            .get();
        if (userData.exists) {
          final String? deviceToken = await sl<FirebaseApi>().refreshToken();
          if (deviceToken == null) {
            emit(LoginError(sl<AppStrings>().errorMessage));
          } else {
            await _updateDoctorDeviceToken(deviceToken).then((value) {
              emit(LoginSuccess());
            });
          }
        } else {
          await FirebaseAuth.instance.signOut();
          emit(LoginError('Email or Password are wrong'));
        }
      });
    } on FirebaseAuthException catch (error) {
      if(error.code=='network-request-failed'){
        emit(LoginError(sl<AppStrings>().checkInternet));
      }else {
        emit(LoginError(error.message.toString()));
      }
    }
  }

  Future<void> _updateDoctorDeviceToken(String token) async {
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'device token': token});
    } catch (error) {
      emit(LoginError(sl<AppStrings>().errorMessage));
    }
  }
}
