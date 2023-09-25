part of 'patient_request_details_cubit.dart';

@immutable
abstract class PatientRequestDetailsState {}

class PatientRequestDetailsInitial extends PatientRequestDetailsState {}

class GetPatientRequestDetailsLoad extends PatientRequestDetailsState {}

class GetPatientRequestDetailsSuccess extends PatientRequestDetailsState {}

class GetPatientRequestDetailsError extends PatientRequestDetailsState {
  final String error;
  GetPatientRequestDetailsError(this.error);
}
