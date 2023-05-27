import 'package:flutter/material.dart';
import 'package:tech_blog/component/my_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: SolidColors.primaryColor,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        textStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return const TextStyle(
              fontSize: 17,
              fontFamily: 'dana',
              fontWeight: FontWeight.w700,
              color: SolidColors.posterTitle,
            );
          }
          return const TextStyle(
            fontSize: 15,
            fontFamily: 'dana',
            fontWeight: FontWeight.w600,
            color: SolidColors.posterSubTitle,
          );
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return SolidColors.seeMore;
          }
          return SolidColors.primaryColor;
        }),
      ),
    ),
    fontFamily: 'dana',
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontFamily: 'dana',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: SolidColors.primaryColor,
      ),
      displayLarge: TextStyle(
        fontFamily: 'dana',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: SolidColors.posterTitle,
      ),
      titleMedium: TextStyle(
        fontFamily: 'dana',
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: SolidColors.posterSubTitle,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'dana',
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),
      displayMedium: TextStyle(
        fontFamily: 'dana',
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
      displaySmall: TextStyle(
        fontFamily: 'dana',
        fontSize: 14,
        color: SolidColors.seeMore,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          color: Color.fromARGB(255, 70, 70, 70),
          fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
        fontFamily: 'dana',
        fontSize: 14,
        color: SolidColors.hintText,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
