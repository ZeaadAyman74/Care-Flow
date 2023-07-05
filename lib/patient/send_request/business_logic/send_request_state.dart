part of 'send_request_cubit.dart';

@immutable
abstract class SendRequestState {}

class SendRequestInitial extends SendRequestState {}

class SendRequestLoad extends SendRequestState {}

class SendRequestSuccess extends SendRequestState {}

class SendRequestError extends SendRequestState {
  final String error;
  SendRequestError(this.error);
}

class PickImageSuccess extends SendRequestState {}
