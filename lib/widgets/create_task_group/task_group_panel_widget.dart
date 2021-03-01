import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_meter/locale/locales.dart';

import '../../core/constants.dart';
import '../../core/utils/duration_utils.dart';
import '../../models/task_group.dart';
import '../duration_picker.dart';

class TaskGroupPanel extends StatefulWidget {
  final TextEditingController titleController;
  final TaskGroup taskGroup;
  final Function showAddNewTaskDialog;
  const TaskGroupPanel({
    this.titleController,
    @required this.taskGroup,
    @required this.showAddNewTaskDialog,
  });

  @override
  _TaskGroupPanelState createState() => _TaskGroupPanelState();
}

class _TaskGroupPanelState extends State<TaskGroupPanel> {
  TextEditingController _durationController;
  AppLocalizations appLocale;
  @override
  void initState() {
    super.initState();
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
          DurationUtils.durationToReadableString(pickedDuration, appLocale);
    });
  }

  @override
  Widget build(BuildContext context) {
    appLocale = AppLocalizations.of(context);
    _durationController = TextEditingController(
        text: DurationUtils.durationToReadableString(
            widget.taskGroup.totalTime, appLocale));
    final shortBreakPicker = Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(appLocale.shortBreak,
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
                    (x) => Text(appLocale.minutes(x),
                        style: TextStyle(
                          color: Colors.black,
                        ))),
                items: List.generate(
                    16,
                    (x) => DropdownMenuItem<Duration>(
                        value: Duration(minutes: x),
                        child: Text(
                          appLocale.minutes(x),
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
              Text(appLocale.longBreakAfter,
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
                      (x) => Text(appLocale.intervals(x + 2),
                          style: TextStyle(color: Colors.black))),
                  items: List.generate(
                      9,
                      (x) => DropdownMenuItem<int>(
                          value: x + 2,
                          child: Text(
                            appLocale.intervals(x + 2),
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
              Text(appLocale.longBreak,
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
                      (x) => Text(appLocale.minutes(x * 5),
                          style: TextStyle(color: Colors.black))),
                  items: List.generate(
                      7,
                      (x) => DropdownMenuItem<Duration>(
                          value: Duration(minutes: x * 5),
                          child: Text(
                            appLocale.minutes(x * 5),
                            // style: Theme.of(context).textTheme.bodyText1
                          )))),
            ]));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocale.createTaskGroup,
                style: Theme.of(context).textTheme.headline1),
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
                        style: TextStyle(fontSize: 22, color: Colors.black),
                        showCursor: true,
                        validator: (string) => string.isEmpty
                            ? appLocale.taskGroupNameErrorText
                            : null,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: appLocale.taskGroupName,
                          border: InputBorder.none,
                        )),
                    SizedBox(height: 10),
                    TextFormField(
                        readOnly: true,
                        style: TextStyle(color: Colors.black),
                        controller: _durationController,
                        onTap: () => _pickDuration(context),
                        decoration: InputDecoration(
                            labelText: appLocale.duration,
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
                    Wrap(direction: Axis.horizontal, children: [
                      shortBreakPicker,
                      longBreakIntervalPicker,
                      longBreakDurationPicker,
                    ]),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        color: widget.taskGroup.taskGroupColor[800],
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          widget.showAddNewTaskDialog();
                        },
                        child: Text(appLocale.addTask,
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
