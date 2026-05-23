import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {

  static Future<void> requestPermission() async {

    FirebaseMessaging messaging =
        FirebaseMessaging.instance;

    NotificationSettings settings =
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );


  }

  static Future<String?> getFCMToken() async {

    return await FirebaseMessaging.instance.getToken();

  }
}