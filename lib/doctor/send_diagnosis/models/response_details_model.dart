import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseDetailsModel {
  final String tips;
  final String medicine;
  final String? coronaCheck;
  final String doctorName;
  final String patientName;
  final int patientAge;
  final String patientEmail;
  final String patientPhone;
  final String xray;
  final String patientNotes;
  final String prevDiseases;
  final String? doctorImage;
  final Timestamp time;
  final String responseId;
  bool isRead;

  ResponseDetailsModel({
    required this.medicine,
    required this.tips,
    required this.coronaCheck,
    required this.doctorName,
    required this.patientName,
    required this.patientAge,
    required this.patientEmail,
    required this.patientPhone,
    required this.isRead,
    required this.prevDiseases,
    required this.patientNotes,
    required this.xray,
    required this.doctorImage,
    required this.time,
    required this.responseId
  });

  factory ResponseDetailsModel.fromJson(Map<String, dynamic> json) {
    return ResponseDetailsModel(
      medicine: json['medicine'],
      tips: json['tips'],
      coronaCheck: json['Corona Check'],
      doctorName: json['doctor name'],
      patientName: json['patientName'],
      patientAge: json['patientAge'],
      patientEmail: json['patientEmail'],
      patientPhone: json['patientPhone'],
      isRead: json['isRead'],
      patientNotes: json['notes'],
      xray: json['xray'],
      prevDiseases: json['prev diseases'],
      doctorImage: json['doctorImage'],
      time: json['time'],
      responseId: json['responseId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tips': tips,
      'medicine': medicine,
      'Corona Check': coronaCheck,
      'doctor name': doctorName,
      'patientName': patientName,
      'patientAge': patientAge,
      'patientEmail': patientEmail,
      'patientPhone': patientPhone,
      'isRead': false,
      'prev diseases': prevDiseases,
      'xray': xray,
      'notes': patientNotes,
      'doctorImage':doctorImage,
      'time':time,
      'responseId':responseId,
    };
  }
}
