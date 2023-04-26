import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const Color primaryColor = Color.fromARGB(255, 55, 130, 100);

  ThemeData darkThemeData = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 255, 100, 100),
      onSecondary: Colors.white,
      error: Color.fromARGB(255, 255, 0, 0),
      onError: Colors.white,
      background: Color.fromARGB(255, 40, 40, 40),
      onBackground: Colors.white,
      surface: Color.fromARGB(255, 40, 40, 40),
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 40, 40, 40),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      foregroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: primaryColor,
      ),
    ),
    textTheme: TextTheme(
      labelLarge: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      labelMedium: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 14,
          color: primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      bodyMedium: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      headlineLarge: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 24,
          color: primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      displayMedium: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      displaySmall: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(0, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(0, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(0, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: darkThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.dark,
    ),
  );
}
