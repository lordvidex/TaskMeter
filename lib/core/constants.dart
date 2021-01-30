import 'package:flutter/material.dart';

class Constants {
  ///[bodyText1] - white text with size 12
  ///[bodyText2] - black text with size 12
  ///[headline1] - white text with biggest title font
  ///[headline2] - black text with biggest title font
  ///[headline3] - white text with mid title font
  ///[headline4] - black text with mid title font
  static ThemeData kThemeData = ThemeData(
      iconTheme: IconThemeData(color: Colors.black, size: 40, opacity: 1.0),
      textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 14, color: Colors.white),
          bodyText2: TextStyle(fontSize: 14, color: Colors.black),
          headline3: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline1: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 24,
            color: Colors.black,
          )));
}
