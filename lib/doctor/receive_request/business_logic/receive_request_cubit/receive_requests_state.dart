part of 'receive_requests_cubit.dart';

@immutable
abstract class ReceiveRequestsState {}

class ReceiveRequestsInitial extends ReceiveRequestsState {}

class ReceiveRequestLoad extends ReceiveRequestsState {}

class ReceiveRequestSuccess extends ReceiveRequestsState {}

class ReceiveRequestError extends ReceiveRequestsState {
  final String error;
  ReceiveRequestError(this.error);
}

class ReadRequest extends ReceiveRequestsState {}

class MarkFinishSuccess extends ReceiveRequestLoad {}

class LoadMoreData extends ReceiveRequestsState {}
