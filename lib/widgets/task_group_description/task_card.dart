import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/utils/duration_utils.dart';
import '../../models/task.dart';
import '../../models/task_group.dart';
import '../../screens/task_timer_screen.dart';

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
            onTap: () => _task.isCompleted
                ? null
                : Navigator.of(context)
                    .pushNamed(TaskTimerScreen.routeName, arguments: _task),
            child: _TaskCard(
                taskGroup: taskGroup, task: _task, isClickable: isClickable),
          )
        : _TaskCard(
            taskGroup: taskGroup, task: _task, isClickable: isClickable);
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    Key key,
    @required this.taskGroup,
    @required Task task,
    @required this.isClickable,
  })  : _task = task,
        super(key: key);

  final TaskGroup taskGroup;
  final Task _task;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    return isClickable
        ? MainTaskCard(task: _task, taskGroup: taskGroup)
        : Dismissible(
            background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white))),
            key: ValueKey(_task.taskId),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) =>
                taskGroup.tasks.removeWhere((t) => t.taskId == _task.taskId),
            child: MainTaskCard(task: _task, taskGroup: taskGroup),
          );
  }
}

class MainTaskCard extends StatelessWidget {
  const MainTaskCard({
    Key key,
    @required Task task,
    @required this.taskGroup,
  })  : _task = task,
        super(key: key);

  final Task _task;
  final TaskGroup taskGroup;

  @override
  Widget build(BuildContext context) {
    return Card(
        color:
            _task.isCompleted ? Colors.grey : Theme.of(context).cardTheme.color,
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
              _task.isCompleted
                  ? Icon(Icons.check, color: Colors.green[800], size: 24)
                  : Text('${(_task.taskProgress * 100).toInt()}%',
                      style: TextStyle(
                          fontSize: 12,
                          color: taskGroup.taskGroupColor[800],
                          fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
