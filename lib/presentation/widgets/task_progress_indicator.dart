import 'package:flutter/material.dart';

import '../../core/constants.dart';

class TaskProgressIndicator extends StatelessWidget {
  final Color backgroundColor;
  final double progress;
  final bool showPercentage;
  const TaskProgressIndicator(this.backgroundColor, this.progress,
      {this.showPercentage = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        if (showPercentage)
          Positioned(
              top: -20,
              right: 0,
              child: Text('${(progress * 100).toInt()}%',
                  style: Constants.coloredLabelTextStyle(backgroundColor))),
        LinearProgressIndicator(
          backgroundColor: backgroundColor,
          value: progress < 0
              ? 0
              : progress > 1
                  ? 1
                  : progress,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ],
    );
  }
}
