import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/send_diagnosis/models/response_details_model.dart';
import 'package:care_flow/patient/send_request/models/request_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_diagnosis_state.dart';

class SendDiagnosisCubit extends Cubit<SendDiagnosisState> {
  SendDiagnosisCubit() : super(SendDiagnosisInitial());

  static SendDiagnosisCubit get(BuildContext context) =>
      BlocProvider.of<SendDiagnosisCubit>(context);
  var firebase = FirebaseFirestore.instance;

  ResponseDetailsModel? response;

  Future<void> sendDiagnosis({
    required final RequestDetailsModel currentRequest,
    required final String tips,
    required final String medicine,
    required final String? coronaCheck,
    required final String doctorName,
    required final doctorImage,
  }) async {
    try {
      emit(SendDiagnosisLoad());
   var doc=firebase
          .collection('patients')
          .doc(currentRequest.patientId)
          .collection('responses')
          .doc();
      response = ResponseDetailsModel(
        medicine: medicine,
        tips: tips,
        coronaCheck: coronaCheck,
        doctorName: doctorName,
        patientName: currentRequest.name,
        patientAge: currentRequest.age,
        patientPhone: currentRequest.phone,
        patientEmail: currentRequest.email,
        isRead: false,
        prevDiseases: currentRequest.prevDiseases,
        patientNotes: currentRequest.notes,
        xray: currentRequest.xrayImage,
        doctorImage: doctorImage,
        time: Timestamp.now(),
        responseId: doc.id,
      );

      await doc.set(response!.toJson());

    await firebase
          .collection('doctors')
          .doc(sl<AppStrings>().uId)
          .collection('diagnoses')
          .doc(doc.id)
          .set(response!.toJson());
      emit(SendDiagnosisSuccess());
    } catch (error) {
      if (error is SocketException) {
        emit(SendDiagnosisError(sl<AppStrings>().checkInternet));
      } else {
        emit(SendDiagnosisError(sl<AppStrings>().checkInternet));
      }
    }
  }
  Future<void> markFinish(String requestId) async {
    try {
      firebase
          .collection('doctors')
          .doc(sl<AppStrings>().uId)
          .collection('requests')
          .doc(requestId)
          .update({'finished': true});
      emit(MarkFinishSuccess());
    } catch (error) {
      if (error is SocketException) {
        emit(SendDiagnosisError(sl<AppStrings>().checkInternet));
      } else {
        emit(SendDiagnosisError(sl<AppStrings>().errorMessage));
      }
    }
  }
}
