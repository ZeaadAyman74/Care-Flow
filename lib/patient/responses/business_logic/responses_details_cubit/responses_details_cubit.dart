import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/send_diagnosis/models/response_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'responses_details_state.dart';

class ResponsesDetailsCubit extends Cubit<ResponsesDetailsState> {
  ResponsesDetailsCubit() : super(ResponsesDetailsInitial());

  static ResponsesDetailsCubit get(BuildContext context) =>
      BlocProvider.of<ResponsesDetailsCubit>(context);

  ResponseDetailsModel? response;

  Future<void> getResponseDetails(String id) async {
    try {
      emit(GetResponseDetailsLoad());
      var currentResponse = await FirebaseFirestore.instance
          .collection('patients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('responses')
          .doc(id)
          .get();
      response = ResponseDetailsModel.fromJson(currentResponse.data()!);
      emit(GetResponseDetailsSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(GetResponseDetailsError(error.code));
      } else {
        emit(GetResponseDetailsError(sl<AppStrings>().errorMessage));
      }
    }
  }
}
