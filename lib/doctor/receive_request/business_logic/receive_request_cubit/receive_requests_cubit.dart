import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/send_request/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'receive_requests_state.dart';

class ReceiveRequestsCubit extends Cubit<ReceiveRequestsState> {
  ReceiveRequestsCubit() : super(ReceiveRequestsInitial());

  static ReceiveRequestsCubit get(BuildContext context) =>
      BlocProvider.of<ReceiveRequestsCubit>(context);

  var firebase = FirebaseFirestore.instance;

  List<RequestModel> requests = [];

  Future<void> getRequests() async {
    try {
      emit(ReceiveRequestLoad());
      var currentRequests = await firebase
          .collection('doctors')
          .doc(sl<AppStrings>().uId)
          .collection('requests')
          .get();
      currentRequests.docs.forEach((element) {
        requests.add(RequestModel.fromJson(element.data()));
      });
      emit(ReceiveRequestSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(ReceiveRequestError(sl<AppStrings>().errorMessage));
      } else if (error is SocketException) {
        emit(ReceiveRequestError(sl<AppStrings>().checkInternet));
      }
    }
  }

  Future<void> readRequest(String id) async {
    emit(ReadRequest());
    firebase
        .collection('doctors')
        .doc(sl<AppStrings>().uId)
        .collection('requests')
        .doc(id)
        .update({'read': true});
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
        emit(ReceiveRequestError(sl<AppStrings>().checkInternet));
      } else {
        emit(ReceiveRequestError(sl<AppStrings>().errorMessage));
      }
    }
  }
}
