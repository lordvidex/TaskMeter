import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/utils/duration_utils.dart';
import '../../models/task.dart';
import '../../models/task_group.dart';
import '../../screens/task_timer_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    this.key,
    @required this.taskGroup,
    @required Task task,
    this.deleteTask,
    this.editTask,
    this.isEditMode = false,
  })  : _task = task,
        assert((isEditMode && deleteTask != null && editTask != null) ||
            (!isEditMode && deleteTask == null && editTask == null)),
        super(key: key);
  final ValueKey key;
  final TaskGroup taskGroup;
  final Function(Task) deleteTask;
  final Task _task;
  final Function({Task taskToBeEdited, bool isEditMode}) editTask;

  /// isTrue when user is in the description screen and false
  /// when user is in the create taskgroup screen
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isEditMode
          ? editTask(taskToBeEdited: _task, isEditMode: true)
          : _task.isCompleted
              ? null
              : Navigator.of(context)
                  .pushNamed(TaskTimerScreen.routeName, arguments: _task),
      child: _TaskCard(
        taskGroup: taskGroup,
        task: _task,
        isEditMode: isEditMode,
        deleteTask: deleteTask,
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    Key key,
    @required this.taskGroup,
    @required Task task,
    @required this.isEditMode,
    @required this.deleteTask,
  })  : _task = task,
        super(key: key);
  final Function(Task) deleteTask;
  final TaskGroup taskGroup;
  final Task _task;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return isEditMode
        ? Dismissible(
            background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white))),
            key: ValueKey(_task.taskId),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => deleteTask(_task),
            child: MainTaskCard(
              task: _task,
              taskGroup: taskGroup,
              isEditMode: isEditMode,
            ),
          )
        : MainTaskCard(
            task: _task,
            taskGroup: taskGroup,
            isEditMode: isEditMode,
          );
  }
}

class MainTaskCard extends StatelessWidget {
  const MainTaskCard({
    Key key,
    @required Task task,
    @required this.taskGroup,
    @required this.isEditMode,
  })  : _task = task,
        super(key: key);

  final Task _task;
  final bool isEditMode;
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
          title: Text(
            _task.taskName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              isEditMode
                  ? 'Difficulty: ${_task.difficulty.index + 1}/3'
                  : DurationUtils.durationToReadableString(
                      _task.timeRemaining ?? Duration.zero),
              style: Constants.coloredLabelTextStyle(Colors.grey)),
          trailing: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
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
