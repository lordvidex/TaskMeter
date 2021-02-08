import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/algorithms/time_divider.dart';
import '../core/errors.dart';
import '../models/settings.dart';
import '../models/task.dart';
import '../models/task_group.dart';
import '../providers/settings_provider.dart';
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
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    settings = Provider.of<SettingsProvider>(context, listen: false).settings;
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
      Scaffold.of(scaffoldContext).removeCurrentSnackBar();
      Scaffold.of(scaffoldContext)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TaskGroupPanel(
                          createTaskGroup: createTaskGroup,
                          addNewTask: addNewTask,
                          taskGroup: newTaskGroup,
                          titleController: taskGroupTitleController,
                        ),
                      ),
                      Expanded(
                        child: newTaskGroup.tasks.length == 0
                            ? Center(
                                child: Flex(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  direction: Axis.horizontal,
                                  children: [
                                    Text('Click '),
                                    Text('Add Task ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('to add a new task')
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (ctx, index) => TaskCard(
                                    taskGroup: newTaskGroup,
                                    isClickable: false,
                                    task: newTaskGroup.tasks[index]),
                                itemCount: newTaskGroup.tasks.length,
                              ),
                      ),
                    ]),
              ),
            )),
      ),
    );
  }
}
