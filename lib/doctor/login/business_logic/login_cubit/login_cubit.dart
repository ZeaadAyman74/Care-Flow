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

  Future<void> loginUser( {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((loginUser) async {
        var userData=await FirebaseFirestore.instance.collection('doctors').doc(loginUser.user!.uid).get();
        if(userData.exists){
          emit(LoginSuccess());
        }else{
          emit(LoginError('Email or Password are wrong'));
        }
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        emit(LoginError(error.toString()));
      } else if (error.code == 'wrong-password') {
        emit(LoginError(error.toString()));
      }
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
