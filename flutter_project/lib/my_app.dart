import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/languageController/language_controller.dart';
import 'package:flutter_project/core/locales/multi_language.dart';
import 'package:flutter_project/screens/authScreens/splash_screen.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 143, 69, 211),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

final navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  final LanguageController languageController = LanguageController();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: MultiLanguage(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: theme,
      home: const Scaffold(
        body: SplashScreen(),
      ),
      navigatorKey: navigatorKey,
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
        },
    );
  }
}
