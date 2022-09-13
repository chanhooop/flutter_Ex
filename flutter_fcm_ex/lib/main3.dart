// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_ex/controller/push_notifications_system.dart';
import 'package:flutter_fcm_ex/firebase_options.dart';
import 'package:flutter_fcm_ex/model/notification_badge.dart';
import 'package:flutter_fcm_ex/model/pushnotification_model.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;

  PushNotification? _notificationInfo;

  @override
  void initState() {
    // normal background
    // registerNotification();
    // app state is terminated
    // checkForInitialMessage();
    _totalNotificationCounter = 0;
    PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
    pushNotificationsSystem.generateDeviceRecognitionToken();
    pushNotificationsSystem.whenNotificationReceived();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('푸시 노티피케이션'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "플러터 푸쉬 노티피케이션",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 12,
            ),
            // showing a notification badgh which will
            // count the tatal notification that we receive
            NotificationBadege(totalNotification: _totalNotificationCounter),
            // if notificationInfo is not null
            _notificationInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                        "TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
