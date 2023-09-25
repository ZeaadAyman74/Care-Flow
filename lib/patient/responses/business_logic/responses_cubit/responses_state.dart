part of 'responses_cubit.dart';

@immutable
abstract class ResponsesState {}

class ResponsesInitial extends ResponsesState {}

class GetResponsesLoad extends ResponsesState {}

class GetResponsesSuccess extends ResponsesState {}

class GetResponsesError extends ResponsesState {
  final String error;
  GetResponsesError(this.error);
}

class LoadMoreData extends ResponsesState {}
