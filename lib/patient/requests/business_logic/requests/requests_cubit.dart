import 'dart:developer';
import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/requests/models/sent_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());

  static RequestsCubit get(BuildContext context) =>
      BlocProvider.of<RequestsCubit>(context);

  final firebaseCollection = FirebaseFirestore.instance
      .collection('patients')
      .doc(sl<AppStrings>().uId)
      .collection('requests');

  List<SentRequestModel> requests = [];
  Future<void> getRequests() async {
    try {
      emit(GetRequestsLoad());
      var currentRequests = await firebaseCollection.orderBy('time', descending: true).limit(5).get();
      currentRequests.docs.forEach((element) {
        print(currentRequests.docs);
        requests.add(SentRequestModel.fromJson(element.data()));
      });
      emit(GetRequestsSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(GetRequestsError(sl<AppStrings>().errorMessage));
      } else if (error is SocketException) {
        emit(GetRequestsError(sl<AppStrings>().checkInternet));
      }
    }
  }

  Future<void> loadMoreData() async {
    try {
      emit(LoadMoreData());
      var moreData = await firebaseCollection
          .orderBy('time', descending: true)
          .where('time', isLessThan: requests.last.dateTime)
          .limit(10)
          .get();
      if (moreData.docs.isNotEmpty) {
        print(moreData.docs);
        moreData.docs.forEach((element) {
          requests.add(SentRequestModel.fromJson(element.data()));
        });
      }
      emit(GetRequestsSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(GetRequestsError(sl<AppStrings>().errorMessage));
      } else if (error is SocketException) {
        emit(GetRequestsError(sl<AppStrings>().checkInternet));
      }
    }
  }
}
