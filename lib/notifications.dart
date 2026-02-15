import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:io';

Future<void> getFCMToken() async {
  if (Platform.isAndroid || Platform.isIOS) {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
  } else {
    print("FCM not supported on this platform.");
  }
}
