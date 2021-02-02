import 'package:flutter/material.dart';
import 'package:task_meter/core/utils/duration_utils.dart';
import 'package:task_meter/screens/task_timer_screen.dart';

import '../../core/constants.dart';
import '../../models/task.dart';
import '../../models/task_group.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key key,
    @required this.taskGroup,
    @required Task task,
    this.isClickable = true,
  })  : _task = task,
        super(key: key);

  final TaskGroup taskGroup;
  final Task _task;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    return isClickable
        ? InkWell(
            onTap: () => Navigator.of(context)
                .pushNamed(TaskTimerScreen.routeName, arguments: _task),
            child: _TaskCard(taskGroup: taskGroup, task: _task),
          )
        : _TaskCard(taskGroup: taskGroup, task: _task);
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    Key key,
    @required this.taskGroup,
    @required Task task,
  })  : _task = task,
        super(key: key);

  final TaskGroup taskGroup;
  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: CircleAvatar(
            backgroundColor: taskGroup.taskGroupColor[800],
            child: Text(_task.taskName[0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          title: Text(_task.taskName,
              style: Constants.coloredLabelTextStyle(Colors.black)),
          subtitle: Text(
              DurationUtils.durationToReadableString(
                  _task.timeRemaining ?? Duration.zero),
              style: Constants.coloredLabelTextStyle(Colors.grey)),
          trailing: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: _task.taskProgress,
                  backgroundColor: taskGroup.taskGroupColor[100],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      taskGroup.taskGroupColor[800]),
                ),
              ),
              Text('${(_task.taskProgress * 100).toInt()}%',
                  style: TextStyle(
                      fontSize: 12,
                      color: taskGroup.taskGroupColor[800],
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
