import 'package:flutter/material.dart';
import 'package:task_meter/core/constants.dart';

class SocialButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonLabel;
  final Widget icon;

  const SocialButton({
    this.icon = const Icon(Icons.favorite),
    @required this.buttonLabel,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 51,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isDarkMode ? Constants.appNavyBlue : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: onPressed,
          splashColor:
              isDarkMode ? Constants.appSkyBlue : Constants.appDarkBlue,
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Center(child: Text(buttonLabel)),
              ),
              Positioned(
                  left: 14,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 24, height: 24, child: icon))
            ],
          ),
        ));
  }
}
