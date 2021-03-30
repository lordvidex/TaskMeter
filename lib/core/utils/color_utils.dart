import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  static const List<MaterialColor> _colors = <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    // Colors.lime,
    // Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    // The grey swatch is intentionally omitted because when picking a color
    // randomly from this list to colorize an application, picking grey suddenly
    // makes the app look disabled.
    Colors.blueGrey,
  ];
  static MaterialColor randomColor() =>
      _colors[Random().nextInt(_colors.length)];
  static MaterialColor getMaterialColorInPos(int pos) => _colors[pos];
  static int getPositionOfMaterialColor(MaterialColor color) =>
      _colors.indexOf(color);
}
