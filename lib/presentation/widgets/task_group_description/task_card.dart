import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils/duration_utils.dart';
import '../../../domain/models/task.dart';
import '../../../domain/models/task_group.dart';
import '../../../locale/locales.dart';
import '../../screens/task_timer_screen.dart';

/// The function called to raise buttom sheet in editmode instead
/// of create mode
typedef EditTask(BuildContext sheetContext, bool isDarkMode,
    {Task? taskToBeEdited, bool isEditMode});

class TaskCard extends StatelessWidget {
  const TaskCard({
    this.key,
    required this.taskGroup,
    required Task task,
    this.deleteTask,
    this.editTask,
    this.isEditMode = false,
  })  : _task = task,
        assert((isEditMode && deleteTask != null && editTask != null) ||
            (!isEditMode && deleteTask == null && editTask == null)),
        super(key: key);
  final ValueKey? key;
  final TaskGroup? taskGroup;
  final Function(Task)? deleteTask;
  final Task _task;
  final EditTask? editTask;

  /// isTrue when user is in the description screen and false
  /// when user is in the create taskgroup screen
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
            onDismissed: (_) => deleteTask!(_task),
            child: MainTaskCard(
              editTask: editTask,
              task: _task,
              taskGroup: taskGroup,
              isEditMode: isEditMode,
            ),
          )
        : MainTaskCard(
            task: _task,
            taskGroup: taskGroup,
            isEditMode: isEditMode,
            editTask: editTask,
          );
  }
}

class MainTaskCard extends StatelessWidget {
  const MainTaskCard({
    Key? key,
    required Task task,
    required this.taskGroup,
    required this.isEditMode,
    required this.editTask,
  })  : _task = task,
        super(key: key);

  final Task _task;
  final bool isEditMode;
  final EditTask? editTask;
  final TaskGroup? taskGroup;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String _difficultyText() {
      switch (_task.difficulty) {
        case Difficulty.Easy:
          return "Easy";
        case Difficulty.Hard:
          return "Hard";
        default:
          return "Medium";
      }
    }

    Color _difficultyColor() {
      switch (_task.difficulty) {
        case Difficulty.Easy:
          return Constants.appGreen;
        case Difficulty.Hard:
          return Constants.appRed;
        default:
          return Constants.appBlue;
      }
    }

    return GestureDetector(
      onTap: _task.isCompleted
          ? null
          : () => isEditMode
              ? editTask!(context, isDarkMode,
                  taskToBeEdited: _task, isEditMode: true)
              : Navigator.of(context)
                  .pushNamed(TaskTimerScreen.routeName, arguments: _task),
      child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Color(0xff0067FF).withOpacity(0.12),
                    offset: Offset(0, 1))
              ],
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _task.taskName!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    if (!isEditMode)
                      Text(
                          DurationUtils.durationToReadableString(
                              _task.timeRemaining ?? Duration.zero, appLocale),
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .color!
                                  .withOpacity(0.72))),
                    Text(_difficultyText(),
                        style:
                            TextStyle(color: _difficultyColor(), fontSize: 12)),
                  ],
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isDarkMode ? Constants.appDarkBlue : Colors.white),
                    child: CircularProgressIndicator(
                      value: _task.taskProgress,
                      strokeWidth: 2.5,
                      backgroundColor: Constants.appLightBlue,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Constants.appBlue),
                    ),
                  ),
                  _task.isCompleted
                      ? Icon(Icons.check, color: Colors.green[800], size: 24)
                      : Text('${(_task.taskProgress * 100).toInt()}%',
                          style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode
                                  ? Constants.appLightBlue
                                  : Constants.appBlue,
                              fontWeight: FontWeight.bold)),
                ],
              )
            ],
          )),
    );
  }
}
