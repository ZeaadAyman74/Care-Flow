part of 'prediction_cubit.dart';

abstract class PredictionState {}

class PredictionInitial extends PredictionState {}

class PickImageSuccess extends PredictionState {}

class LoadModelLoading extends PredictionState {}

class LoadModelSuccess extends PredictionState {}

class LoadModelError extends PredictionState {
  String error;
  LoadModelError(this.error);
}

class GetPredictionSuccess extends PredictionState {}

class GetPredictionError extends PredictionState {
  String error;
  GetPredictionError(this.error);
}
