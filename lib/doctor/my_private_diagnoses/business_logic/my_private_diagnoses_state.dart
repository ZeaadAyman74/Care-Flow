part of 'my_private_diagnoses_cubit.dart';

@immutable
abstract class MyPrivateDiagnosesState {}

class MyPrivateDiagnosesInitial extends MyPrivateDiagnosesState {}

class GetMyPrivateDiagnosesLoad extends MyPrivateDiagnosesState {}

class GetMyPrivateDiagnosesSuccess extends MyPrivateDiagnosesState {}

class GetMyPrivateDiagnosesError extends MyPrivateDiagnosesState {
 final String error;
  GetMyPrivateDiagnosesError(this.error);
}

