part of 'patient_register_cubit.dart';

abstract class PatientRegisterState {}

class ChangePassVisibility extends PatientRegisterState {}

class PatientRegisterInitial extends PatientRegisterState {}

class RegisterPatientLoad extends PatientRegisterState {}

class RegisterPatientSuccess extends PatientRegisterState {}

class RegisterPatientError extends PatientRegisterState {
  String error;
  RegisterPatientError(this.error);
}

class CreatePatientError extends PatientRegisterState {
  String error;
  CreatePatientError(this.error);
}
