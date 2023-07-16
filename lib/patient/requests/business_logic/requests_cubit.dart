import 'dart:io';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());

  static RequestsCubit get(BuildContext context) =>
      BlocProvider.of<RequestsCubit>(context);
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  List<RequestModel> requests = [];

  Future<void> getRequests() async {
    try {
      var currentRequests = await firebase
          .collection('patients')
          .doc(AppStrings.uId)
          .collection('requests')
          .get();
      currentRequests.docs.forEach((request) {
        requests.add(RequestModel.fromJson(request.data()));
        emit(GetRequestsSuccess());
      });
    } catch (error) {
      if (error is SocketException) {
        emit(GetRequestsError(AppStrings.checkInternet));
      } else {
        emit(GetRequestsError(AppStrings.errorMessage));
      }
    }
  }
}
