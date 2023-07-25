class MedicineReminderModel {
  final String medicine;
  final DateTime time;
  MedicineReminderModel({
    required this.medicine,
    required this.time,
});

  factory MedicineReminderModel.fromJson(Map<String,dynamic>json){
    return MedicineReminderModel(medicine: json['medicine'], time: json['time']);
  }

  Map<String,dynamic>toJson(){
    return {
      'medicine':medicine,
      'time':time,
    };
  }
}