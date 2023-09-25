part of 'responses_details_cubit.dart';

@immutable
abstract class ResponsesDetailsState {}

class ResponsesDetailsInitial extends ResponsesDetailsState {}

class GetResponseDetailsLoad extends ResponsesDetailsState {}

class GetResponseDetailsSuccess extends ResponsesDetailsState {}

class GetResponseDetailsError extends ResponsesDetailsState {
  final String error;
  GetResponseDetailsError(this.error);
}
