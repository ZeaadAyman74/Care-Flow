import 'dart:convert';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/network/dio_helper.dart';
import 'package:care_flow/core/notifications/notifications.dart';
import 'package:care_flow/core/routing/routes.dart';
import 'package:care_flow/main.dart';
import 'package:care_flow/notifications/notifications_types.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> handleBackGroundMessage(RemoteMessage? message) async {
  if (kDebugMode) {
    print(message!.data);
  }
    if (message == null) return;
    if(message.data['type']==NotificationsTypes.request) {
      navigatorKey.currentState?.pushNamed(Routes.requestDetailsRoute, arguments: message.data['requestId']);
    }

}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: true,
      carPlay: false,
      provisional: false,
      criticalAlert: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      } else {
        if (kDebugMode) {
          print('User has not accepted permission');
        }
      }
    }
  } // this request for IOS & MacOs & Web

  Future<String?>getDeviceToken()async{
    return _firebaseMessaging.getToken();
  }
  Future<String?>refreshToken()async{
    await _firebaseMessaging.deleteToken();
    return await _firebaseMessaging.getToken();
  }

  Future<void> fcmSettings() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );  /* for apple notifications when received in the foreground */
    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage); /* when the app open from terminated state */
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);   /*  when app is in background */
    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);  /* when app is in background */
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      sl<NotificationsApi>().showNotification(
        id: 0,
        title: notification!.title,
        body: notification.body,
        payLoad: jsonEncode(message.toMap()),
      );
    });  /* when app is in foreground */
  }

  Future<void> initNotifications() async {
    await requestPermission();
    await fcmSettings();
    await sl<NotificationsApi>().init();
  }

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
      navigatorKey.currentState?.pushNamed(Routes.requestDetailsRoute, arguments: {'id':message.data['requestId']});
  }   // for navigation to the required screen with required data if found


Future<void>pushNotification({required String token,required Map<String,dynamic>data,required Map<String,dynamic>notification})async{
 try{
   await  sl<DioHelper>().postData(path: 'https://fcm.googleapis.com/fcm/send', data:
   {
     'priority':'high',
     'data':data,
     'notification':notification,
     'to':token,
     'content-available':true,
   });
 }catch(error){
   if (kDebugMode) {
     print(error.toString());
   }
 }
}


// Future<void>updateDeviceToken(String token)async{
//     String currentRole=sl<AppStrings>().role!;
//     String role=currentRole=='p'?'patients':'doctors';
//   await FirebaseFirestore.instance
//       .collection(role)
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .update({
//     'tokens': FieldValue.arrayUnion([token]),
//   });
// }
}
