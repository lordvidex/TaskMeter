import 'package:flutter/material.dart';

class TaskGroupWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final MaterialColor taskGroupColor;
  const TaskGroupWidget({
    @required this.taskGroupColor,
    @required this.title,
    @required this.subtitle,
    @required this.progress,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        //height: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: taskGroupColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headline3),
            SizedBox(height: 20),
            Text(subtitle, style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: LinearProgressIndicator(
                backgroundColor: taskGroupColor[100],
                value: progress < 0
                    ? 0
                    : progress > 1
                        ? 1
                        : progress,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          ],
        ));
  }
}
