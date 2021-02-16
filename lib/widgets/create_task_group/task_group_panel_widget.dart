import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../duration_picker.dart';

import '../../core/constants.dart';
import '../../core/utils/duration_utils.dart';
import '../../models/task.dart';
import '../../models/task_group.dart';
import 'add_task_widget.dart';

class TaskGroupPanel extends StatefulWidget {
  final Function(BuildContext) createTaskGroup;
  final TextEditingController titleController;
  final TaskGroup taskGroup;
  final int taskDays;
  final Function(Task) addNewTask;
  const TaskGroupPanel({
    this.titleController,
    @required this.createTaskGroup,
    @required this.taskGroup,
    this.taskDays,
    @required this.addNewTask,
  });

  @override
  _TaskGroupPanelState createState() => _TaskGroupPanelState();
}

class _TaskGroupPanelState extends State<TaskGroupPanel> {
  TextEditingController _durationController;
  @override
  void initState() {
    super.initState();
    _durationController = TextEditingController(
        text:
            DurationUtils.durationToReadableString(widget.taskGroup.totalTime));
  }

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  void _pickDuration(BuildContext context) async {
    FocusScope.of(context).unfocus();
    Duration pickedDuration = await showDurationPicker(
        context: context, initialTime: Duration(minutes: 30), snapToMins: 1);
    if (pickedDuration == null) {
      return;
    }
    setState(() {
      widget.taskGroup.totalTime = pickedDuration;
      _durationController.text =
          DurationUtils.durationToReadableString(pickedDuration);
    });
  }

  @override
  Widget build(BuildContext context) {
    final shortBreakPicker = Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Short Break',
                  style: Constants.coloredLabelTextStyle(
                      widget.taskGroup.taskGroupColor[800])),
              DropdownButton<Duration>(
                iconEnabledColor: Colors.grey[700],
                value: widget.taskGroup.shortBreakTime,
                onChanged: (x) {
                  widget.taskGroup.shortBreakTime = x;
                  setState(() {});
                },
                isDense: true,
                selectedItemBuilder: (ctx) => List.generate(
                    16,
                    (x) => Text('$x minutes',
                        style: TextStyle(
                          color: Colors.black,
                        ))),
                items: List.generate(
                    16,
                    (x) => DropdownMenuItem<Duration>(
                        value: Duration(minutes: x),
                        child: Text(
                          '$x minutes',
                        ))),
              )
            ]));

    final longBreakIntervalPicker = Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Long Break After',
                  style: Constants.coloredLabelTextStyle(
                      widget.taskGroup.taskGroupColor[800])),
              DropdownButton<int>(
                  iconEnabledColor: Colors.grey[700],
                  value: widget.taskGroup.longBreakIntervals,
                  onChanged: (x) {
                    widget.taskGroup.longBreakIntervals = x;
                    setState(() {});
                  },
                  isDense: true,
                  selectedItemBuilder: (ctx) => List.generate(
                      9,
                      (x) => Text('${x + 2} intervals',
                          style: TextStyle(color: Colors.black))),
                  items: List.generate(
                      9,
                      (x) => DropdownMenuItem<int>(
                          value: x + 2,
                          child: Text(
                            '${x + 2} intervals',
                            //style: Theme.of(context).textTheme.bodyText1
                          )))),
            ]));

    final longBreakDurationPicker = Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Long Break',
                  style: Constants.coloredLabelTextStyle(
                      widget.taskGroup.taskGroupColor[800])),
              DropdownButton<Duration>(
                  value: widget.taskGroup.longBreakTime,
                  iconEnabledColor: Colors.grey[700],
                  onChanged: (x) {
                    widget.taskGroup.longBreakTime = x;
                    setState(() {});
                  },
                  isDense: true,
                  selectedItemBuilder: (ctx) => List.generate(
                      7,
                      (x) => Text('${x * 5} minutes',
                          style: TextStyle(color: Colors.black))),
                  items: List.generate(
                      7,
                      (x) => DropdownMenuItem<Duration>(
                          value: Duration(minutes: x * 5),
                          child: Text(
                            '${x * 5} minutes',
                            // style: Theme.of(context).textTheme.bodyText1
                          )))),
            ]));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(CupertinoIcons.back, size: 32)),
                RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    icon: Icon(Icons.check, color: Colors.white, size: 30),
                    onPressed: () => widget.createTaskGroup(context),
                    color: Colors.green,
                    label: Text('Create',
                        style: Constants.coloredLabelTextStyle(Colors.white)))
              ],
            ),
            SizedBox(height: 10),
            Text('Create Task', style: Theme.of(context).textTheme.headline1),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20),
                decoration:
                    BoxDecoration(color: widget.taskGroup.taskGroupColor[100]),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        cursorColor: Colors.grey,
                        controller: widget.titleController,
                        style: TextStyle(fontSize: 26, color: Colors.black),
                        showCursor: true,
                        validator: (string) => string.isEmpty
                            ? 'Enter a valid task group name'
                            : null,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: 'Task Group Name',
                          border: InputBorder.none,
                        )),
                    SizedBox(height: 10),
                    TextFormField(
                        readOnly: true,
                        style: TextStyle(color: Colors.black),
                        controller: _durationController,
                        onTap: () => _pickDuration(context),
                        decoration: InputDecoration(
                            labelText: 'Duration',
                            labelStyle: TextStyle(color: Colors.black54),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: widget.taskGroup.taskGroupColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: widget.taskGroup.taskGroupColor)),
                            suffixIcon: Icon(Icons.alarm_rounded,
                                color: Colors.black))),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        shortBreakPicker,
                        longBreakIntervalPicker,
                        longBreakDurationPicker,
                      ]),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        color: widget.taskGroup.taskGroupColor[800],
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (ctx) => AlertDialog(
                                      content: AddTaskWidget(
                                    taskGroup: widget.taskGroup,
                                    addNewTask: widget.addNewTask,
                                  )),
                              //,
                              barrierDismissible: false);
                        },
                        child: Text('Add Task',
                            style: Constants.coloredLabelTextStyle(
                                widget.taskGroup.taskGroupColor[100])),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
