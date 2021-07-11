import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static Color get appGreen => Color(0xff62C370);
  static Color get appRed => Color(0xffC36262);
  static Color get appBlue => Color(0xff0067FF);
  static Color get appLightBlue => Color(0xffCCE1FF);
  static Color get appLightRed => Color(0xffFFCCE1);
  static Color get appLightGreen => Color(0xffCCFFE1);
  static Color get appNavyBlue => Color(0xff1D2554);
  static Color get appDarkBlue => Color(0xff111424);

  ///`colorLabelTextStyle` takes a `Color` argument
  ///and returns a TextStyle with a `bold` text and the color specified
  static TextStyle coloredLabelTextStyle(Color color, {double fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
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
        fontSize: 14,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      headline6: TextStyle(color: Colors.black, fontSize: 20),
      headline3: TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
      headline1: TextStyle(
          fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold));

  static ThemeData kThemeData = ThemeData(
      iconTheme: _lightIconTheme,
      cardTheme: CardTheme(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        brightness: Brightness.light,
        iconTheme: _lightIconTheme,
      ),
      primaryTextTheme: _lightTextTheme,
      textTheme: _lightTextTheme);
  static ThemeData kDarkThemeData = ThemeData(
      cardTheme: CardTheme(
          color: appDarkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white, size: 40, opacity: 1.0),
      textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          headline3: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          headline1: TextStyle(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold)));
}
