import 'dart:io';

import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/private_diagnosis/models/private_diagnosis_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'my_private_diagnoses_state.dart';

class MyPrivateDiagnosesCubit extends Cubit<MyPrivateDiagnosesState> {
  MyPrivateDiagnosesCubit() : super(MyPrivateDiagnosesInitial());

  static MyPrivateDiagnosesCubit get(BuildContext context)=>BlocProvider.of<MyPrivateDiagnosesCubit>(context);

  List<PrivateDiagnosisModel>privateDiagnoses=[];
  Future<void>getMyPrivateDiagnoses()async{
    try{
      emit(GetMyPrivateDiagnosesLoad());
    final currentPrivateDiagnoses=await  FirebaseFirestore.instance.collection('doctors').doc(sl<AppStrings>().uId).collection('private diagnosis').get();
    currentPrivateDiagnoses.docs.forEach((element) {
      privateDiagnoses.add(PrivateDiagnosisModel.fromJson(element.data()));
    });
    emit(GetMyPrivateDiagnosesSuccess());
    }catch(error){
      if(error is SocketException){
        emit(GetMyPrivateDiagnosesError(sl<AppStrings>().checkInternet));
      }else {
        emit(GetMyPrivateDiagnosesError(sl<AppStrings>().errorMessage));
        print(error.toString());
      }
    }
  }
}
