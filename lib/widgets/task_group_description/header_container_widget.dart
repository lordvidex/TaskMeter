import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../locale/locales.dart';
import '../../models/task_group.dart';
import '../task_progress_indicator.dart';

class HeaderContainerWidget extends StatelessWidget {
  const HeaderContainerWidget({
    Key key,
    @required this.taskGroup,
  }) : super(key: key);

  final TaskGroup taskGroup;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      child: Stack(children: [
        Positioned(
            top: -10,
            right: -10,
            child: Icon(Icons.alarm,
                size: 200, color: taskGroup.taskGroupColor[600])),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon:
                      Icon(CupertinoIcons.back, color: Colors.white, size: 32)),
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 0),
                constraints: BoxConstraints(maxHeight: 150),
                width: MediaQuery.of(context).size.width - 170,
                child: Text(
                  taskGroup.taskGroupName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                  appLocale
                      .taskCount(taskGroup.tasks.length),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(appLocale.progress,
                  style: Constants.coloredLabelTextStyle(
                      taskGroup.taskGroupColor[100])),
              SizedBox(height: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TaskProgressIndicator(
                    taskGroup.taskGroupColor[100],
                    taskGroup.taskGroupProgress,
                    showPercentage: true,
                  )),
              SizedBox(height: 10),
            ],
          ),
        )
      ]),
      decoration: BoxDecoration(
          color: taskGroup.taskGroupColor[800],
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
    );
  }
}
