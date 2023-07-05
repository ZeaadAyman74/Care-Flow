import 'dart:io';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/send_diagnosis/models/response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'diagnoses_state.dart';

class DiagnosesCubit extends Cubit<DiagnosesState> {
  DiagnosesCubit() : super(DiagnosesInitial());

  static DiagnosesCubit get(BuildContext context) =>
      BlocProvider.of<DiagnosesCubit>(context);

  List<ResponseModel> diagnoses = [];

  Future<void> getMyDiagnoses() async {
    emit(GetMyDiagnosesLoad());
    try {
      var currentDiagnoses = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(AppStrings.uId)
          .collection('diagnoses')
          .get();
      currentDiagnoses.docs.forEach((diagnosis) {
        diagnoses.add(ResponseModel.fromJson(diagnosis.data()));
        emit(GetMyDiagnosesSuccess());
      });
    } catch (error) {
      if (error is SocketException) {
        emit(GetMyDiagnosesError(AppStrings.checkInternet));
      } else {
        emit(GetMyDiagnosesError(AppStrings.errorMessage));
      }
    }
  }
}
