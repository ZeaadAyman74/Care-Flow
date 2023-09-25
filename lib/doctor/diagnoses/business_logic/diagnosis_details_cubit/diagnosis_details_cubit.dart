import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/send_diagnosis/models/response_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'diagnosis_details_state.dart';

class DiagnosisDetailsCubit extends Cubit<DiagnosisDetailsState> {
  DiagnosisDetailsCubit() : super(DiagnosisDetailsInitial());

static DiagnosisDetailsCubit get(BuildContext context)=>BlocProvider.of<DiagnosisDetailsCubit>(context);

ResponseDetailsModel? response;

  Future<void> getDiagnosisDetails(String id) async {
    try {
      emit(GetDiagnosisDetailsLoad());
      var currentResponse = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('diagnoses')
          .doc(id)
          .get();
      print(currentResponse.id);
      print(currentResponse.data());
      response = ResponseDetailsModel.fromJson(currentResponse.data()!);
      emit(GetDiagnosisDetailsSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(GetDiagnosisDetailsError(error.code));
      } else {
        print(error.toString());
        emit(GetDiagnosisDetailsError(sl<AppStrings>().errorMessage));
      }
    }
  }

}
