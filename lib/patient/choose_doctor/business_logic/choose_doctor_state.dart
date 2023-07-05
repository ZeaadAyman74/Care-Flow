part of 'choose_doctor_cubit.dart';

@immutable
abstract class ChooseDoctorState {}

class ChooseDoctorInitial extends ChooseDoctorState {}

class GetDoctorsLoad extends ChooseDoctorState {}

class GetDoctorsSuccess extends ChooseDoctorState {}

class GetDoctorsError extends ChooseDoctorState {
  final String error;
  GetDoctorsError(this.error);
}
