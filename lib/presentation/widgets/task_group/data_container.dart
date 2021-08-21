import 'package:flutter/material.dart';
import 'package:task_meter/core/constants.dart';

class DataContainer extends StatelessWidget {
  final String label;
  final String text;
  final bool isDarkMode;

  const DataContainer(
      {required this.label, required this.text, required this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      padding: const EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(fontSize: 48)),
          Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [Constants.appNavyBlue, Colors.black]
                  : [Color(0xffEEF4FD), Constants.appLightBlue]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isDarkMode ? Colors.white : Constants.appNavyBlue,
              width: 1)),
    );
  }
}
