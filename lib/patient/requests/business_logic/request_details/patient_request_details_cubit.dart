import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/send_request/models/request_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_request_details_state.dart';

class PatientRequestDetailsCubit extends Cubit<PatientRequestDetailsState> {
  PatientRequestDetailsCubit() : super(PatientRequestDetailsInitial());

  static PatientRequestDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

   RequestDetailsModel? request;

  Future<void> getPatientRequestDetails(String requestId) async {
    emit(GetPatientRequestDetailsLoad());
    try {
      var currentRequest = await FirebaseFirestore.instance
          .collection('patients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('requests')
          .doc(requestId)
          .get();
      request = RequestDetailsModel.fromJson(currentRequest.data()!);
      emit(GetPatientRequestDetailsSuccess());
    } on FirebaseException catch (error) {
      emit(GetPatientRequestDetailsError(error.code));
    } catch (error) {
      emit(GetPatientRequestDetailsError(sl<AppStrings>().errorMessage));
    }
  }
}
