import 'dart:io';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/send_diagnosis/models/response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'responses_state.dart';

class ResponsesCubit extends Cubit<ResponsesState> {
  ResponsesCubit() : super(ResponsesInitial());
  
  static ResponsesCubit get(BuildContext context)=>BlocProvider.of<ResponsesCubit>(context);

  List<ResponseModel>responses=[];
  Future<void>getResponses()async{
    emit(GetResponsesLoad());
    try{
      var currentResponses=await FirebaseFirestore.instance.collection('patients').doc(AppStrings.uId).collection('responses').get();
      currentResponses.docs.forEach((response) {
        responses.add(ResponseModel.fromJson(response.data()));
      });
      emit(GetResponsesSuccess());
    }catch(error){
      if(error is SocketException){
        emit(GetResponsesError(AppStrings.checkInternet));
      }
      emit(GetResponsesError(AppStrings.errorMessage));
    }
  }
}
