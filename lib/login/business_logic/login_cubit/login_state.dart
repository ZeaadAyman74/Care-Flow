part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangePassVisibility extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState{
  String error;
  LoginError(this.error);
}
