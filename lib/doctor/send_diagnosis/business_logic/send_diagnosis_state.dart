part of 'send_diagnosis_cubit.dart';

@immutable
abstract class SendDiagnosisState {}

class SendDiagnosisInitial extends SendDiagnosisState {}

class SendDiagnosisLoad extends SendDiagnosisState {}

class SendDiagnosisSuccess extends SendDiagnosisState {}

class SendDiagnosisError extends SendDiagnosisState {
  final String error;
  SendDiagnosisError(this.error);
}

class MarkFinishSuccess extends SendDiagnosisState {}
