import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/firebase_api/firebase_api.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/my_app.dart';
//main

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}


