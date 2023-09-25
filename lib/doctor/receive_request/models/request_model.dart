import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id;
  final String name;
  final Timestamp time;
  bool isRead;

  RequestModel({
    required this.id,
    required this.name,
    required this.isRead,
    required this.time,
});
  
  factory RequestModel.fromJson(Map<String,dynamic>json){
    return RequestModel(id: json['requestId'], name: json['name'],isRead: json['read'],time: json['time']);
  }

  Map<String,dynamic>toJson(){
    return {
      'requestId':id,
      'name':name,
      'is read':isRead,
      'time':time,
    };
  }
}