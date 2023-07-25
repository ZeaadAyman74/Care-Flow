import 'package:care_flow/core/fcm/fcm.dart';
import 'package:care_flow/core/notifications/notifications.dart';
import 'package:care_flow/core/notifications/second_page.dart';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/colors.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    // listenNotification();
    super.initState();
  }

  // void listenNotification() => sl<NotificationsApi>().onNotifications.stream.listen(onClickedNotification);

  // void onClickedNotification(String? payload) =>
  //     Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => const SecondPage(),
  //     ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        onPressed: () async => await sl<FirebaseApi>().pushNotification(),
        // await sl<NotificationsApi>().showScheduleNotification(
        //     title: 'Coding',
        //     body: 'Writing the graduation project code',
        //     payload: 'lets gooooo',
        //     scheduleTime: DateTime.now().add(const Duration(seconds: 10))),
        color: sl<MyColors>().primary,
        child: const Text('Show notifications'),
      )),
    );
  }
}
