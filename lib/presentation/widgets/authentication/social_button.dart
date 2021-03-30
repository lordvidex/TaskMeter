import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final Function() onPressed;
  final Color buttonColor;
  final String buttonLabel;
  final Widget icon;
  final Color textColor;
  const SocialButton({
    this.icon = const Icon(Icons.favorite),
    @required this.buttonLabel,
    @required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColor = Colors.blue,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton.icon(
            label: Text(buttonLabel,
                style: TextStyle(color: textColor, fontFamily: 'Roboto')),
            icon: icon,
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: buttonColor,
            )));
  }
}
