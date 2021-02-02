import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/core/algorithms/time_divider.dart';
import 'package:task_meter/core/errors.dart';
import 'package:task_meter/injection_container.dart';
import 'package:task_meter/models/settings.dart';
import 'package:task_meter/providers/settings_provider.dart';

import '../models/task.dart';
import '../models/task_group.dart';
import '../providers/task_group_provider.dart';
import '../widgets/create_task_group/task_group_panel_widget.dart';
import '../widgets/task_group_description/task_card.dart';

class CreateTaskGroupScreen extends StatefulWidget {
  static const routeName = '/new-task-group';
  @override
  _CreateTaskGroupScreenState createState() => _CreateTaskGroupScreenState();
}

class _CreateTaskGroupScreenState extends State<CreateTaskGroupScreen> {
  GlobalKey<FormState> _formKey;
  TaskGroup newTaskGroup;
  Settings settings;

  /// TextEditingController for the TaskGroupTitle
  TextEditingController taskGroupTitleController;

  /// TextEditingController for the days
  TextEditingController durationDaysController;

  /// TextEditingController for the hours
  TextEditingController durationHoursController;

  /// TextEditingController for the minutes
  TextEditingController durationMinutesController;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    settings = Provider.of<SettingsProvider>(context, listen: false).settings;
    newTaskGroup = TaskGroup('',
        longBreakIntervals: settings.longBreakIntervals,
        shortBreakTime: settings.shortBreak,
        longBreakTime: settings.longBreak);
    taskGroupTitleController = TextEditingController();
    durationDaysController = TextEditingController(text: '0');
    durationHoursController = TextEditingController(text: '0');
    durationMinutesController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void createTaskGroup() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    newTaskGroup.taskGroupName = taskGroupTitleController.text;
    newTaskGroup.totalTime = Duration(
        days: int.parse(durationDaysController.text),
        hours: int.parse(durationHoursController.text),
        minutes: int.parse(durationMinutesController.text));
    //TODO: do validations
    try {
      TimeDivider.divideTimeByTask(newTaskGroup);
    } on TaskTimerException catch (e) {
      //TODO: properly show validation errors
      print(e.toString());
      return;
    }
    Provider.of<TaskGroupProvider>(context, listen: false)
        .addTaskGroup(newTaskGroup);
    // go to the main page
    Navigator.of(context).pop();
  }

  void addNewTask(Task newTask) {
    setState(() {
      newTaskGroup.tasks.add(newTask);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex == newTaskGroup.tasks.length) {
        newIndex = newTaskGroup.tasks.length - 1;
      }
      var item = newTaskGroup.tasks.removeAt(oldIndex);
      newTaskGroup.tasks.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 7,
                        child: TaskGroupPanel(
                            createTaskGroup: createTaskGroup,
                            addNewTask: addNewTask,
                            taskGroup: newTaskGroup,
                            titleController: taskGroupTitleController,
                            daysController: durationDaysController,
                            hoursController: durationHoursController,
                            minutesController: durationMinutesController)),
                    Flexible(
                        flex: 5,
                        child: ReorderableListView(
                          children: newTaskGroup.tasks
                              .map((t) => TaskCard(
                                    key: ObjectKey(t.taskId),
                                    task: t,
                                    taskGroup: newTaskGroup,
                                    isClickable: false,
                                  ))
                              .toList(),
                          onReorder: _onReorder,
                        )
                        ),
                  ]),
            ),
          )),
    );
  }
}
