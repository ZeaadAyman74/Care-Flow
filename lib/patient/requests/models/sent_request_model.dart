import 'package:cloud_firestore/cloud_firestore.dart';

class SentRequestModel {
  final String doctorName;
  final String requestId;
  final String specialize;
  final Timestamp dateTime;
  bool isRead;

  SentRequestModel({
    required this.doctorName,
    required this.specialize,
    required this.requestId,
    required this.dateTime,
    required this.isRead,
  });

  factory SentRequestModel.fromJson(Map<String, dynamic>json){
    return SentRequestModel(doctorName: json['doctorName'],
        specialize: json['doctorSpecialize'],
        requestId: json['requestId'],
        dateTime: json['time'],
        isRead: json['read']);
  }

}