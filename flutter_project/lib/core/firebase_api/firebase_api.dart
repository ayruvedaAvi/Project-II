
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_project/my_app.dart';
import 'package:flutter_project/screens/authScreens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('title: ${message.notification?.body}');
  print('title: ${message.data}');
}

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(
      SplashScreen.route,
      arguments: message,
    );
  }

  

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', fCMToken!);
    print('token: $fCMToken');
    initPushNotifications();
  }
}
