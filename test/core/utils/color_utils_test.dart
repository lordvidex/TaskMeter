import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/core/utils/color_utils.dart';

void main() {
  test('should return Colors.red when Material color in position 0 is called',
      () {
    // arrange
    // act
    // assert
    expect(ColorUtils.getMaterialColorInPos(0), Colors.red);
  });
  test('should return `int` value 0 when Colors.red is converted to int', () {
    // arrange
    // act
    // assert
    expect(ColorUtils.getPositionOfMaterialColor(Colors.red), equals(0));
  });
}
