part of 'private_diagnosis_cubit.dart';

abstract class PrivateDiagnosisState {}

class PrivateDiagnosisInitial extends PrivateDiagnosisState {}

class SaveDiagnosisLoad extends PrivateDiagnosisState {}

class SaveDiagnosisSuccess extends PrivateDiagnosisState {}

class SaveDiagnosisError extends PrivateDiagnosisState {
 final String error;
  SaveDiagnosisError(this.error);
}