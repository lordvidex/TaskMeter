import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Widget icon;
  final Color color;
  final bool filled;
  final bool wide;

  const ActionButton(
      {@required this.onPressed,
      this.filled = true,
      this.wide = false,
      @required this.color,
      @required this.text,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            Text(text,
                style: TextStyle(
                    fontFamily: 'Circular-Std',
                    color: filled ? Colors.white : color,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            if (icon != null) ...[SizedBox(width: 8), icon]
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: wide ? 64 : 32, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: filled ? color : Colors.transparent,
            border: Border.all(width: 2, color: color)),
      ),
    );
  }
}
