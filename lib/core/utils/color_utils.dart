import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  static List<MaterialColor> _colors = Colors.primaries;
  static MaterialColor randomColor() =>
      _colors[Random().nextInt(_colors.length)];
}
