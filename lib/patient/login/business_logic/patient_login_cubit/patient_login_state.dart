part of 'patient_login_cubit.dart';

abstract class PatientLoginState {}

class ChangePassVisibility extends PatientLoginState {}

class PatientLoginInitial extends PatientLoginState {}

class PatientLoginLoad extends PatientLoginState {}

class PatientLoginSuccess extends PatientLoginState {}

class PatientLoginError extends PatientLoginState {
  String error;
  PatientLoginError(this.error);
}
