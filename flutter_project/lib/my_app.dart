import 'package:flutter/material.dart';
import 'package:flutter_project/screens/splash_screen.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 204, 140, 37),
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.robotoMonoTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
