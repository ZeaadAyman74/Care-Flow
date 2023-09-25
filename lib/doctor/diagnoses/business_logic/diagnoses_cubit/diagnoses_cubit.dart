import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/diagnoses/models/diagnosis_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'diagnoses_state.dart';

class DiagnosesCubit extends Cubit<DiagnosesState> {
  DiagnosesCubit() : super(DiagnosesInitial());

  static DiagnosesCubit get(BuildContext context) =>
      BlocProvider.of<DiagnosesCubit>(context);

  final firebaseCollection = FirebaseFirestore.instance
      .collection('doctors')
      .doc(sl<AppStrings>().uId)
      .collection('diagnoses');

  List<DiagnosisModel> diagnoses = [];

  Future<void> getMyDiagnoses() async {
    emit(GetMyDiagnosesLoad());
    try {
      var currentDiagnoses = await firebaseCollection.orderBy('time',descending: true).limit(5).get();
      print(currentDiagnoses);
      currentDiagnoses.docs.forEach((diagnosis) {
        diagnoses.add(DiagnosisModel.fromJson(diagnosis.data()));
      });
      emit(GetMyDiagnosesSuccess());
    } catch (error) {
      if (error is SocketException) {
        emit(GetMyDiagnosesError(sl<AppStrings>().checkInternet));
      } else {
        emit(GetMyDiagnosesError(sl<AppStrings>().errorMessage));
      }
    }
  }

  Future<void> loadMoreData() async {
    try {
      emit(LoadMoreData());
      var moreData = await firebaseCollection
          .orderBy('time', descending: true)
          .where('time', isLessThan: diagnoses.last.time)
          .limit(10)
          .get();
      if (moreData.docs.isNotEmpty) {
        print(moreData.docs);
        moreData.docs.forEach((element) {
          diagnoses.add(DiagnosisModel.fromJson(element.data()));
        });
      }
      emit(GetMyDiagnosesSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(GetMyDiagnosesError(sl<AppStrings>().errorMessage));
      } else if (error is SocketException) {
        emit(GetMyDiagnosesError(sl<AppStrings>().checkInternet));
      }
    }
  }
}
