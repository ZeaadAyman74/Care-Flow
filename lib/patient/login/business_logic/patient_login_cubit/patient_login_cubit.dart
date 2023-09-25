import 'dart:io';

import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/fcm/fcm.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'patient_login_state.dart';

class PatientLoginCubit extends Cubit<PatientLoginState> {
  PatientLoginCubit() : super(PatientLoginInitial());

  static PatientLoginCubit get(BuildContext context)=>BlocProvider.of<PatientLoginCubit>(context);


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

  Future<void> loginPatient({required String email,required String password})async{
    emit(PatientLoginLoad());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((loginUser) async {
        var userData = await FirebaseFirestore.instance
            .collection('patients')
            .doc(loginUser.user!.uid)
            .get();
        if (userData.exists) {
          final String? deviceToken = await sl<FirebaseApi>().refreshToken();
          if (deviceToken == null) {
            emit(PatientLoginError(sl<AppStrings>().errorMessage));
          } else {
            await _updatePatientDeviceToken(deviceToken).then((value) {
              emit(PatientLoginSuccess());
            });
          }
        } else {
          await FirebaseAuth.instance.signOut();
          emit(PatientLoginError('Email or Password are wrong'));
        }
      });
    } on FirebaseAuthException catch (error) {
      emit(PatientLoginError(error.toString()));
    } catch (error) {
      if (error is SocketException) {
        emit(PatientLoginError(sl<AppStrings>().checkInternet));
      } else {
        emit(PatientLoginError(sl<AppStrings>().errorMessage));
      }
    }
  }

  Future<void> _updatePatientDeviceToken(String token) async {
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'device token': token});
    } catch (error) {
      emit(PatientLoginError(sl<AppStrings>().errorMessage));
    }
  }

}
