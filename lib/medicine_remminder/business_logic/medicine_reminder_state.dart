part of 'medicine_reminder_cubit.dart';

@immutable
abstract class MedicineReminderState {}

class MedicineReminderInitial extends MedicineReminderState {}

class AddMedicineLoad extends MedicineReminderState {}

class AddMedicineSuccess extends MedicineReminderState {}

class AddMedicineError extends MedicineReminderState {
  final String error;
  AddMedicineError(this.error);
}

class GetMyRemindersLoad extends MedicineReminderState {}

class GetMyRemindersSuccess extends MedicineReminderState {}

class GetMyRemindersError extends MedicineReminderState {
  final String error;
  GetMyRemindersError(this.error);
}
