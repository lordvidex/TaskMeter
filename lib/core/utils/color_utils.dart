import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  static List<MaterialColor> _colors = Colors.primaries;
  static MaterialColor randomColor() =>
      _colors[Random().nextInt(_colors.length)];
  static MaterialColor getMaterialColorInPos(int pos) => _colors[pos];
  static int getPositionOfMaterialColor(MaterialColor color) =>
      _colors.indexOf(color);
}
