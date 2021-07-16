import 'package:flutter/material.dart';

import '../../core/constants.dart';

class TaskProgressIndicator extends StatelessWidget {
  final double progress;
  final bool showPercentage;
  final bool isDarkMode;
  const TaskProgressIndicator(this.progress,
      {@required this.isDarkMode, this.showPercentage = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (showPercentage)
          Positioned(
              top: -20,
              right: 0,
              child: Text('${(progress * 100).toInt()}%',
                  style: TextStyle(
                      fontSize: 12,
                      color:
                          isDarkMode ? Colors.white : Constants.appNavyBlue))),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: LinearProgressIndicator(
            backgroundColor:
                isDarkMode ? Colors.white.withOpacity(0.4) : Color(0xffEEf4FD),
            value: progress < 0
                ? 0
                : progress > 1
                    ? 1
                    : progress,
            valueColor: AlwaysStoppedAnimation<Color>(
                isDarkMode ? Constants.appLightBlue : Constants.appNavyBlue),
          ),
        ),
      ],
    );
  }
}
