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

  static IconThemeData _lightIconTheme =
      IconThemeData(color: Colors.black, size: 40, opacity: 1.0);

  ///[bodyText1] - black text with size 12
  ///[bodyText2] - white text with size 12
  ///[headline1] - black text with biggest title font
  ///[headline2] - white text with biggest title font
  ///[headline3] - black text with mid title font
  ///[headline4] - white text with mid title font
  static TextTheme _lightTextTheme = TextTheme(
      bodyText1: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      headline3: TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      headline1: TextStyle(
          fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold));

  static ThemeData kThemeData = ThemeData(
      iconTheme: _lightIconTheme,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: _lightIconTheme,
      ),
      primaryTextTheme: _lightTextTheme,
      textTheme: _lightTextTheme);
  static ThemeData kDarkThemeData = ThemeData(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white, size: 40, opacity: 1.0),
      textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          headline3: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline1: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)));
}
