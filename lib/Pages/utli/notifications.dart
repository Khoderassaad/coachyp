import 'package:firebase_messaging/firebase_messaging.dart';

void setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions on iOS
  NotificationSettings settings = await messaging.requestPermission();

  // Get FCM token
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  // Listen to foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message in foreground: ${message.notification?.title}');
  });

  // Background and terminated state
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message opened app: ${message.notification?.title}');
  });
}
