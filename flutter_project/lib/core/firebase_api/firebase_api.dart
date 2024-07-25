import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/my_app.dart';
import 'package:flutter_project/screens/authScreens/splash_screen.dart';
import 'package:flutter_project/utils/shared_preferences/shared_preference.dart';
import 'package:get/get.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('title: ${message.notification?.title}');
  debugPrint('title: ${message.notification?.body}');
  debugPrint('title: ${message.data}');
}

class FirebaseApi {
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
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint("Foregroundmessage: $message");
      // Handle the incoming message when the app is in the foreground
      Get.showSnackbar(
        GetSnackBar(
          title: message.notification!.title.toString(),
          message: message.notification!.body.toString(),
          duration: const Duration(seconds: 5),
          backgroundGradient: const LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: 10,
          isDismissible: true,
          margin: const EdgeInsets.all(10),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING,
          padding: const EdgeInsets.all(10),
          icon: const Icon(Icons.notifications_active_rounded,
              color: Colors.white),
          boxShadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      );

      return; // Optional for handling multiple messages (rarely needed)
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    UserSharedPreference.saveDataToStorage('fcmToken', fCMToken);
    debugPrint('token: $fCMToken');
    initPushNotifications();
  }
}
