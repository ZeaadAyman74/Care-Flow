import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/medicine_remminder/models/medicine_remminder_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'medicine_reminder_state.dart';

class MedicineReminderCubit extends Cubit<MedicineReminderState> {
  MedicineReminderCubit() : super(MedicineReminderInitial());

  static MedicineReminderCubit get(BuildContext context) =>
      BlocProvider.of<MedicineReminderCubit>(context);

  MedicineReminderModel? medicineReminder;
  Future<void> addMedicine({
    required final String medicine,
    required final DateTime time,
  }) async {
    emit(AddMedicineLoad());
    medicineReminder = MedicineReminderModel(medicine: medicine, time: time);
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(sl<AppStrings>().uId)
          .collection('medicine reminder')
          .doc()
          .set(medicineReminder!.toJson())
          .then((value) {
        addToReminders(medicineReminder!);
      });
    } catch (error) {
      if (error is SocketException) {
        emit(AddMedicineError(sl<AppStrings>().checkInternet));
      } else {
        emit(AddMedicineError(sl<AppStrings>().errorMessage));
      }
    }
  }

  List<MedicineReminderModel> medicineReminders = [];
  Future<void> getMyReminders() async {
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(sl<AppStrings>().uId)
          .collection('medicine reminder')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          medicineReminders.add(MedicineReminderModel.fromJson(element.data()));
        });
        emit(GetMyRemindersSuccess());
      });
    } catch (error) {
      if (error is SocketException) {
        emit(GetMyRemindersError(sl<AppStrings>().checkInternet));
      } else {
        emit(GetMyRemindersError(sl<AppStrings>().errorMessage));
      }
    }
  }

  void addToReminders(MedicineReminderModel model) {
    medicineReminders.add(model);
    emit(AddMedicineSuccess());
  }
}
