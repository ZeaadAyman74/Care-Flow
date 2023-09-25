import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/patient/responses/models/response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'responses_state.dart';

class ResponsesCubit extends Cubit<ResponsesState> {
  ResponsesCubit() : super(ResponsesInitial());
  
  static ResponsesCubit get(BuildContext context)=>BlocProvider.of<ResponsesCubit>(context);


  final firebaseCollection=FirebaseFirestore.instance.collection('patients').doc(sl<AppStrings>().uId).collection('responses');
  List<ResponseModel>responses=[];
  Future<void>getResponses()async{
    emit(GetResponsesLoad());
    try{
      var currentResponses=await firebaseCollection.get();
      currentResponses.docs.forEach((response) {
        responses.add(ResponseModel.fromJson(response.data()));
      });
      emit(GetResponsesSuccess());
    }catch(error){
      if(error is SocketException){
        emit(GetResponsesError(sl<AppStrings>().checkInternet));
      }
      emit(GetResponsesError(sl<AppStrings>().errorMessage));
    }
  }

  Future<void> loadMoreData() async {
    try {
      emit(LoadMoreData());
      var moreData = await firebaseCollection
          .orderBy('time', descending: true)
          .where('time', isLessThan: responses.last.time)
          .limit(10)
          .get();
      if (moreData.docs.isNotEmpty) {
        print(moreData.docs);
        moreData.docs.forEach((element) {
          responses.add(ResponseModel.fromJson(element.data()));
        });
      }
      emit(GetResponsesSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(GetResponsesError(sl<AppStrings>().errorMessage));
      } else if (error is SocketException) {
        emit(GetResponsesError(sl<AppStrings>().checkInternet));
      }
    }
  }

}
