import 'package:care_flow/doctor/register/models/register_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'choose_doctor_state.dart';

class ChooseDoctorCubit extends Cubit<ChooseDoctorState> {
  ChooseDoctorCubit() : super(ChooseDoctorInitial());

  static ChooseDoctorCubit get(BuildContext context)=>BlocProvider.of<ChooseDoctorCubit>(context);

  List<DoctorModel> doctors = [];

  Future<void> getDoctors({
    required String specialization,
  }) async {
    emit(GetDoctorsLoad());
    try {
      final data = await FirebaseFirestore.instance
          .collection('doctors')
          .where('specialize', isEqualTo: specialization)
          .get();
      data.docs.forEach((doctor) {
        doctors.add(DoctorModel.fromJson(doctor.data()));
      });
      emit(GetDoctorsSuccess());
    } catch (error) {
      emit(GetDoctorsError('some thing went wrong, please try again'));
    }
  }
}
