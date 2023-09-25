import 'package:care_flow/notifications/notifications_types.dart';

class NotificationModel {
  final NotificationsTypes type;
  final String id;

  NotificationModel({
    required this.id,
    required this.type,
});

  factory NotificationModel.fromJson(Map<String,dynamic>json){
    return NotificationModel(id: json['id'], type: json['type']);
  }

  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'type':type,
    };
  }
}