import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/algorithms/time_divider.dart';
import '../../core/constants.dart';
import '../../core/errors.dart';
import '../../locale/locales.dart';
import '../../domain/models/settings.dart';
import '../../domain/models/task.dart';
import '../../domain/models/task_group.dart';
import '../providers/settings_provider.dart';
import '../providers/task_group_provider.dart';
import '../widgets/create_task_group/add_task_widget.dart';
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
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    settings = context.read<SettingsProvider>().settings;
    newTaskGroup = TaskGroup('',
        longBreakIntervals: settings.longBreakIntervals,
        shortBreakTime: settings.shortBreak,
        longBreakTime: settings.longBreak,
        totalTime: settings.totalTime);
    taskGroupTitleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    taskGroupTitleController.dispose();
  }

  void createTaskGroup(BuildContext scaffoldContext) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    newTaskGroup.taskGroupName = taskGroupTitleController.text;
    //TODO: do validations
    try {
      TimeDivider.divideTimeByTask(newTaskGroup);
    } on TaskTimerException catch (e) {
      // error occured and should be shown to user in snackbar
      ScaffoldMessenger.of(scaffoldContext).removeCurrentSnackBar();
      ScaffoldMessenger.of(scaffoldContext)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }
    context.read<TaskGroupProvider>().addTaskGroup(newTaskGroup);
    // go to the main page
    Navigator.of(context).pop();
  }

  void addNewTask(Task newTask, {bool isEditMode = false}) {
    setState(() {
      if (!isEditMode) newTaskGroup.tasks.add(newTask);
    });
  }

  void deleteTask(Task task) {
    setState(() {
      newTaskGroup.tasks.removeWhere((t) => t.taskId == task.taskId);
    });
  }

  void showAddNewTaskDialog({Task taskToBeEdited, bool isEditMode = false}) {
    assert((isEditMode && taskToBeEdited != null) ||
        !isEditMode && taskToBeEdited == null);
    showDialog(
        context: context,
        useRootNavigator: true,
        builder: (ctx) => AlertDialog(
                content: AddTaskWidget(
              taskGroup: newTaskGroup,
              addNewTask: addNewTask,
              isEditMode: isEditMode,
              taskToBeEdited: taskToBeEdited,
            )),
        //,
        barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                icon: Icon(Icons.check, color: Colors.white, size: 30),
                onPressed: () => createTaskGroup(context),
                color: Colors.green,
                label: Text(appLocale.create,
                    style: Constants.coloredLabelTextStyle(Colors.white))),
          )
        ],
      ),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: mediaQuery.size.height -
                    mediaQuery.padding.top -
                    mediaQuery.padding.bottom,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 58,
                        child: TaskGroupPanel(
                          showAddNewTaskDialog: showAddNewTaskDialog,
                          taskGroup: newTaskGroup,
                          titleController: taskGroupTitleController,
                        ),
                      ),
                      Expanded(
                        flex: 45,
                        child: newTaskGroup.tasks.length == 0
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        text: appLocale.click,
                                        children: [
                                          TextSpan(
                                            text: appLocale.addTask,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text: appLocale.toAddNewTask)
                                        ]),
                                  ),
                                ),
                              )
                            : ReorderableListView(
                                children: newTaskGroup.tasks
                                    .map((t) => TaskCard(
                                        key: ValueKey(t.taskId),
                                        taskGroup: newTaskGroup,
                                        deleteTask: deleteTask,
                                        isEditMode: true,
                                        editTask: showAddNewTaskDialog,
                                        task: t))
                                    .toList(),
                                onReorder: (oldIndex, newIndex) {
                                  if (newIndex < 0) {
                                    newIndex = 0;
                                  }
                                  if (newIndex >= newTaskGroup.tasks.length) {
                                    newIndex = newTaskGroup.tasks.length - 1;
                                  }
                                  Task temp = newTaskGroup.tasks[oldIndex];
                                  newTaskGroup.tasks[oldIndex] =
                                      newTaskGroup.tasks[newIndex];
                                  newTaskGroup.tasks[newIndex] = temp;
                                  setState(() {});
                                }),
                      ),
                    ]),
              ),
            )),
      ),
    );
  }
}
