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
        var userData=await FirebaseFirestore.instance.collection('patients').doc(loginUser.user!.uid).get();
        if(userData.exists){
          emit(PatientLoginSuccess());
        }else{
          emit(PatientLoginError('Email or Password are wrong'));
        }
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        emit(PatientLoginError(error.toString()));
      } else if (error.code == 'wrong-password') {
        emit(PatientLoginError(error.toString()));
      }
    } catch (error) {
      emit(PatientLoginError(error.toString()));
    }
  }
}
