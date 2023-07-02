import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/register_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

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
    required String address,
    required String specialization,
    required String about,
  }) async {
    emit(RegisterLoad());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createDoctor(
        email: email,
        phone: phone,
        name: name,
        firebaseUserId: credential.user!.uid,
        address: address,
        nId: nId,
        specialization: specialization,
        about: about,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterError('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> createDoctor({
    required String name,
    required String email,
    required String phone,
    required String firebaseUserId,
    required String nId,
    required String address,
    required String specialization,
    required String about,
  }) async {
    emit(CreateUserLoad());
    DoctorModel userData = DoctorModel(
      name: name,
      email: email,
      phone: phone,
      nationalId: nId,
      address: address,
      specialize: specialization,
      about: about,
      uId: firebaseUserId,
    );
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(firebaseUserId)
          .set(userData.toJson());
      emit(CreateUserSuccess());
    } catch (error) {
      emit(CreateUserError(error.toString()));
    }
  }

  List<String> specialties = [
    'Lung diseases',
    'Cardiology',
    'Orthopedic ',
    'Brain diseases',
    'Ophthalmologist',
    'Dermatologist',
    'Urologist',
    'Otolaryngologies ',
  ];
}
