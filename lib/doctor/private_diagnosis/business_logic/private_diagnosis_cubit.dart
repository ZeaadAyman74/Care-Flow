import 'dart:io';
import 'package:care_flow/doctor/private_diagnosis/models/private_diagnosis_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'private_diagnosis_state.dart';

class PrivateDiagnosisCubit extends Cubit<PrivateDiagnosisState> {
  PrivateDiagnosisCubit() : super(PrivateDiagnosisInitial());

  static PrivateDiagnosisCubit get(BuildContext context) =>
      BlocProvider.of<PrivateDiagnosisCubit>(context);

  PrivateDiagnosisModel? diagnosisModel;

  Future<void> saveDiagnosis({
    required String? name,
    required String? age,
    required String result,
    required String? notes,
    required String image,
  }) async {
    emit(SaveDiagnosisLoad());
    diagnosisModel = PrivateDiagnosisModel(
        age: age, name: name, result: result, notes: notes, image: image);
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('private diagnosis')
          .doc()
          .set(diagnosisModel!.toJson());
    } catch (error) {
      emit(SaveDiagnosisError('Something went wrong please try again'));
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<void> uploadImage({
    required String? name,
    required String? age,
    required String result,
    required String? notes,
    required File image,
  }) async {
    try {
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(image.path).pathSegments.last}')
          .putFile(image);
      String imageUrl = await value.ref.getDownloadURL();
     await saveDiagnosis(name: name, age: age, result: result, notes: notes, image: imageUrl);
      emit(SaveDiagnosisSuccess());
    } catch (error) {
      emit(SaveDiagnosisError('Some thing went error, please try again'));
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}
