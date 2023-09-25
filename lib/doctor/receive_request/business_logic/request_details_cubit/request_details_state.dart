part of 'request_details_cubit.dart';

@immutable
abstract class RequestDetailsState {}

class RequestDetailsInitial extends RequestDetailsState {}

class GetRequestDetailsLoad extends RequestDetailsState {}

class GetRequestDetailsSuccess extends RequestDetailsState {}

class GetRequestDetailsError extends RequestDetailsState {
  final String error;
  GetRequestDetailsError(this.error);
}

class LoadModel extends RequestDetailsState {}

class LoadModelSuccess extends RequestDetailsState {}

class LoadModelError extends RequestDetailsState {
  final String error;
  LoadModelError(this.error);
}

class PredictionSuccess extends RequestDetailsState {}

class PredictionError extends RequestDetailsState {
  final String error;
  PredictionError(this.error);
}
