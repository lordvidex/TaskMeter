import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/task_group.dart';
import 'task_progress_indicator.dart';

class TaskGroupWidget extends StatelessWidget {
  final TaskGroup taskGroup;
  const TaskGroupWidget({@required this.taskGroup});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 3),
        margin: const EdgeInsets.all(15),
        //height: 300,
        decoration: BoxDecoration(
          color: taskGroup.taskGroupColor[400],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(children: [
          Positioned(
              right: -10,
              bottom: -30,
              child: SvgPicture.asset('assets/icons/checklists.svg',
                  color: taskGroup.taskGroupColor[500])),
          Row(children: [
            Flexible(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(taskGroup.taskGroupName,
                        style: Theme.of(context).textTheme.headline3),
                    SizedBox(height: 20),
                    Text(taskGroup.taskGroupSubtitle,
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 5),
                    Text('progress',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: taskGroup.taskGroupColor[100],
                        )),
                    SizedBox(height: 3),
                    TaskProgressIndicator(taskGroup.taskGroupColor[100],
                        taskGroup.taskGroupProgress)
                  ],
                ),
              ),
            ),
            Flexible(flex: 3, child: Container())
          ]),
        ]));
  }
}
