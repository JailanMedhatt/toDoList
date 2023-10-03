import 'package:flutter/material.dart';

class MyTheme {
  static Color lightBgColor = Color(0xffDFECDB);
  static Color primartight = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color darkBgColor = Color(0xff060E1E);
  static Color darkGrey = Color(0xff141922);
  static Color greenColor=Color(0xff61E757);
  static ThemeData lighTheme = ThemeData(
      primaryColor: primartight,
      appBarTheme: AppBarTheme(elevation: 0),
      scaffoldBackgroundColor: lightBgColor,
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: whiteColor),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xff383838)),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(0xff383838))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: primartight,
          unselectedItemColor: Color(0xffC8C9CB),
          elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primartight,
          shape: StadiumBorder(side: BorderSide(color: whiteColor, width: 3))));

  static ThemeData darkTheme = ThemeData(
      primaryColor: primartight,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: primartight,
      ),
      scaffoldBackgroundColor: darkBgColor,
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: darkBgColor),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: whiteColor),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: whiteColor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: primartight,
          unselectedItemColor: whiteColor,
          elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primartight,
          shape: StadiumBorder(side: BorderSide(color: darkGrey, width: 5))));
}
