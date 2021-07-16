import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon({
    @required this.child,
    this.size = 24,
    @required this.gradient,
  });

  final Widget child;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size,
        height: size,
        child: child,
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
