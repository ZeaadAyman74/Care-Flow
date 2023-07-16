part of 'requests_cubit.dart';

@immutable
abstract class RequestsState {}

class RequestsInitial extends RequestsState {}

class GetRequestsLoad extends RequestsState {}

class GetRequestsSuccess extends RequestsState {}

class GetRequestsError extends RequestsState {
  final String error;
  GetRequestsError(this.error);
}
