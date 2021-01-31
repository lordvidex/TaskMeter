import 'package:flutter/material.dart';

class Constants {
  ///`colorLabelTextStyle` takes a `Color` argument
  ///and returns a TextStyle with a `bold` text and the color specified
  static TextStyle coloredLabelTextStyle(Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  ///[bodyText1] - white text with size 12
  ///[bodyText2] - black text with size 12
  ///[headline1] - white text with biggest title font
  ///[headline2] - black text with biggest title font
  ///[headline3] - white text with mid title font
  ///[headline4] - black text with mid title font
  static ThemeData kThemeData = ThemeData(
      iconTheme: IconThemeData(color: Colors.black, size: 40, opacity: 1.0),
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.black),
          headline3: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline1: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)));
}
