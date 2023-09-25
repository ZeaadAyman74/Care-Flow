import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseModel {
  final String doctorName;
  final String? doctorImage;
  final String responseId;
  final Timestamp time;

  ResponseModel({
    required this.doctorName,
    required this.responseId,
    required this.time,
    required this.doctorImage,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        doctorName: json['doctor name'],
        doctorImage: json['doctorImage'],
        responseId: json['responseId'],
        time: json['time'],

    );
  }
}
