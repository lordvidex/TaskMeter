import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../models/task.dart';
import '../../models/task_group.dart';
import 'add_task_widget.dart';
import 'time_textformfield.dart';

class TaskGroupPanel extends StatelessWidget {
  final Function createTaskGroup;
  final TextEditingController titleController;
  final TextEditingController daysController;
  final TextEditingController hoursController;
  final TextEditingController minutesController;
  final TaskGroup taskGroup;
  final Function(Task) addNewTask;
  const TaskGroupPanel(
      {this.titleController,
      @required this.createTaskGroup,
      @required this.taskGroup,
      @required this.addNewTask,
      this.daysController,
      this.minutesController,
      this.hoursController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Positioned(
              top: 15,
              left: 0,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(CupertinoIcons.back,
                      color: Colors.black, size: 32))),
          Positioned(
              top: 25,
              right: 0,
              child: RaisedButton.icon(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.check, color: Colors.white, size: 30),
                  onPressed: createTaskGroup,
                  color: Colors.green,
                  label: Text('Create',
                      style: Constants.coloredLabelTextStyle(Colors.white)))),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Text('Create Task',
                    style: Theme.of(context).textTheme.headline2),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration:
                        BoxDecoration(color: taskGroup.taskGroupColor[100]),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            cursorColor: Colors.grey,
                            controller: titleController,
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
                        Text('Duration',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(children: [
                          Text('Days '),
                          TimeTextFormField(controller: daysController),
                          SizedBox(width: 15),
                          Text('Hours '),
                          TimeTextFormField(controller: hoursController),
                          SizedBox(width: 15),
                          Text('Minutes '),
                          TimeTextFormField(controller: minutesController),
                        ]),
                        SizedBox(height: 40),
                        Align(
                          alignment: Alignment.center,
                          child: CupertinoButton(
                            color: taskGroup.taskGroupColor[800],
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              showDialog(
                                  context: context,
                                  useRootNavigator: true,
                                  builder: (ctx) => AlertDialog(
                                          content: AddTaskWidget(
                                        taskGroup: taskGroup,
                                        addNewTask: addNewTask,
                                      )),
                                  //,
                                  barrierDismissible: false);
                            },
                            child: Text('Add Task',
                                style: Constants.coloredLabelTextStyle(
                                    taskGroup.taskGroupColor[100])),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
