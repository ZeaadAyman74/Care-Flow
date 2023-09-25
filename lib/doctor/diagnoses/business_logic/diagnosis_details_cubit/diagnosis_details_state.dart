part of 'diagnosis_details_cubit.dart';

@immutable
abstract class DiagnosisDetailsState extends Equatable {}

class DiagnosisDetailsInitial extends DiagnosisDetailsState {
  @override
  List<Object?> get props => [];
}

class GetDiagnosisDetailsLoad extends DiagnosisDetailsState {
  @override
  List<Object?> get props => [];
}

class GetDiagnosisDetailsSuccess extends DiagnosisDetailsState {
  @override
  List<Object?> get props => [];
}

class GetDiagnosisDetailsError extends DiagnosisDetailsState {
  final String error;

  GetDiagnosisDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}
