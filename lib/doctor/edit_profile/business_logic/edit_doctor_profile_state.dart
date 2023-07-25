part of 'edit_doctor_profile_cubit.dart';

abstract class EditDoctorProfileState {}

class EditDoctorProfileInitial extends EditDoctorProfileState {}

class EditDoctorProfileLoad extends EditDoctorProfileState {}

class EditDoctorProfileSuccess extends EditDoctorProfileState {}

class EditDoctorProfileError extends EditDoctorProfileState {
  final String error;
  EditDoctorProfileError(this.error);
}

class PickImageSuccess extends EditDoctorProfileState {}
