import 'package:cloud_firestore/cloud_firestore.dart';

class RequestDetailsModel {
  final String name;
  final String email;
  final String phone;
  final int age;
  final String patientId;
  final String notes;
  final String prevDiseases;
  final String xrayImage;
  final String? requestId;
  final String doctorName;
  final String doctorSpecialize;
  final Timestamp time;
   bool read;
   bool finished;

  RequestDetailsModel({
    required this.name,
    required this.age,
    required this.phone,
    required this.email,
    required this.prevDiseases,
    required this.xrayImage,
    required this.notes,
    required this.patientId,
    required this.doctorName,
    required this.doctorSpecialize,
    required this.read,
    required this.finished,
    required this.time,
    this.requestId,
  });

  factory RequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return RequestDetailsModel(
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      email: json['email'],
      prevDiseases: json['prevDiseases'],
      xrayImage: json['xray'],
      notes: json['notes'],
      patientId: json['patientId'],
      requestId: json['requestId'],
      doctorName: json['doctorName'],
      doctorSpecialize: json['doctorSpecialize'],
      read: json['read'],
      finished: json['finished'],
      time:json['time'],
    );
  }

  Map<String, dynamic> toJson(String id) {
    return {
      'name': name,
      'email': email,
      'age': age,
      'phone': phone,
      'prevDiseases': prevDiseases,
      'xray': xrayImage,
      'notes':notes,
      'patientId':patientId,
      'doctorSpecialize':doctorSpecialize,
      'doctorName':doctorName,
      'read':read,
      'requestId':id,
      'finished':finished,
      'time':time,
    };
  }
}
