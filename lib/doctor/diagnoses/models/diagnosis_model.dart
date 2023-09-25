import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosisModel {
  final String patientName;
  final String diagnosisId;
  final Timestamp time;

  DiagnosisModel({
    required this.patientName,
    required this.diagnosisId,
    required this.time,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
        patientName: json['patientName'],
        diagnosisId: json['responseId'],
        time: json['time']);
  }
}
