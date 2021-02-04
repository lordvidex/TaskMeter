import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

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
  Duration _shortBreakDuration;
  Duration _longBreakDuration;
  int _longBreakIntervals;
  @override
  void initState() {
    super.initState();
    _shortBreakDuration = widget.taskGroup.shortBreakTime;
    _longBreakDuration = widget.taskGroup.longBreakTime;
    _longBreakIntervals = widget.taskGroup.longBreakIntervals;
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon:
                      Icon(CupertinoIcons.back, color: Colors.black, size: 32)),
              RaisedButton.icon(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.check, color: Colors.white, size: 30),
                  onPressed: () => widget.createTaskGroup(context),
                  color: Colors.green,
                  label: Text('Create',
                      style: Constants.coloredLabelTextStyle(Colors.white)))
            ],
          ),
          SizedBox(height: 10),
          Text('Create Task', style: Theme.of(context).textTheme.headline2),
          Container(
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
                      style: TextStyle(fontSize: 26),
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
                      controller: _durationController,
                      onTap: () => _pickDuration(context),
                      decoration: InputDecoration(
                          labelText: 'Duration',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Icon(Icons.alarm_rounded))),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Short Break:',
                            style: Constants.coloredLabelTextStyle(
                                widget.taskGroup.taskGroupColor[800])),
                        Text('Long Break',
                            style: Constants.coloredLabelTextStyle(
                                widget.taskGroup.taskGroupColor[800])),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<Duration>(
                            value: widget.taskGroup.shortBreakTime,
                            hint: Text('Short Break Duration'),
                            onChanged: (x) {
                              widget.taskGroup.shortBreakTime = x;
                              setState(() => _shortBreakDuration = x);
                            },
                            items: List.generate(
                                16,
                                (x) => DropdownMenuItem<Duration>(
                                    value: Duration(minutes: x),
                                    child: Text('$x minutes')))),
                        DropdownButton<Duration>(
                            value: widget.taskGroup.longBreakTime,
                            hint: Text('Long Break Duration'),
                            onChanged: (x) {
                              widget.taskGroup.longBreakTime = x;
                              setState(() => _longBreakDuration = x);
                            },
                            items: List.generate(
                                7,
                                (x) => DropdownMenuItem<Duration>(
                                    value: Duration(minutes: x * 5),
                                    child: Text('${x * 5} minutes')))),
                      ]),
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
    );
  }
}
