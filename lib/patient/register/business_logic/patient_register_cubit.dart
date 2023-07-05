import 'package:care_flow/patient/register/models/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'patient_register_state.dart';

class PatientRegisterCubit extends Cubit<PatientRegisterState> {
  PatientRegisterCubit() : super(PatientRegisterInitial());

  static PatientRegisterCubit get(BuildContext context)=>BlocProvider.of<PatientRegisterCubit>(context);

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

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String nId,
    required String gender,
    required int age,
  }) async {
    emit(RegisterPatientLoad());
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,);
      await createPatient(
        email: email,
        phone: phone,
        name: name,
        firebaseUserId: credential.user!.uid,
        nId: nId,
        age: age,
        gender: gender,
      );
      emit(RegisterPatientSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterPatientError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterPatientError('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterPatientError(e.toString()));
    }
  }

  Future<void> createPatient({
    required String name,
    required String email,
    required String phone,
    required String firebaseUserId,
    required String nId,
    required int age,
    required String gender,
  }) async {
    PatientModel patientData = PatientModel(
        name: name,
        email: email,
        phone: phone,
        nationalId: nId,
      gender: gender,
      age: age,
    );
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(firebaseUserId)
          .set(patientData.toJson());
    } catch (error) {
      emit(CreatePatientError(error.toString()));
    }
  }
}
