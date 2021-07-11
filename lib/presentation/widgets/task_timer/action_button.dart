import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Widget icon;
  final EdgeInsets padding;
  final Color fillColor;
  final bool filled;
  final Color textColor;
  final Color borderColor;
  final bool wide;

  const ActionButton(
      {@required this.onPressed,
      this.filled = true,
      this.wide = false,
      this.textColor,
      this.padding,
      this.borderColor,
      @required this.fillColor,
      @required this.text,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      splashColor: fillColor,
      onTap: onPressed,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    fontFamily: 'Circular-Std',
                    color: textColor ?? (filled ? Colors.white : fillColor),
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            if (icon != null) ...[SizedBox(width: 8), icon]
          ],
        ),
        padding: padding ??
            EdgeInsets.symmetric(horizontal: wide ? 64 : 32, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: filled ? fillColor : Colors.transparent,
            border: Border.all(
                width: 2,
                color: filled ? fillColor : borderColor ?? fillColor)),
      ),
    );
  }
}
