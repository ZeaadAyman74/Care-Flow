part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoad extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  String error;
  RegisterError(this.error);
}

class CreateUserLoad extends RegisterState{}

class CreateUserSuccess extends RegisterState {}

class CreateUserError extends RegisterState {
 final String error;
  CreateUserError(this.error);
}

class ChangePassVisibility extends RegisterState {}