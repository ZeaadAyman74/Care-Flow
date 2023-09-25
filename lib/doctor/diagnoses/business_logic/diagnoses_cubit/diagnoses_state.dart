part of 'diagnoses_cubit.dart';

@immutable
abstract class DiagnosesState {}

class DiagnosesInitial extends DiagnosesState {}

class GetMyDiagnosesLoad extends DiagnosesState {}

class GetMyDiagnosesSuccess extends DiagnosesState {}

class GetMyDiagnosesError extends DiagnosesState {
 final String error;
 GetMyDiagnosesError(this.error);
}

class LoadMoreData extends DiagnosesState {}
