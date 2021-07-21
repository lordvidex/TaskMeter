import 'package:flutter/material.dart';
import 'package:task_meter/core/constants.dart';

class SettingsButton<T> extends StatelessWidget {
  final String child;
  final bool isSelected;
  final T value;
  final Function() onPressed;
  const SettingsButton({
    @required this.child,
    @required this.value,
    @required this.isSelected,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextButton(
      child: Text(
        child,
        style: TextStyle(
            fontSize: 18,
            color: isDarkMode ? Colors.white : Constants.appNavyBlue),
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: isSelected
                  ? BorderSide(
                      width: 1.5,
                      color: isDarkMode ? Colors.white : Constants.appNavyBlue)
                  : BorderSide.none),
          backgroundColor:
              isDarkMode ? Constants.appDarkBlue : Constants.appSkyBlue,
          padding: const EdgeInsets.symmetric(vertical: 15)),
    );
  }
}
