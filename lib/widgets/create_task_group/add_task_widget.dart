import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/constants.dart';
import '../../models/task.dart';
import '../../models/task_group.dart';

class AddTaskWidget extends StatefulWidget {
  final Function(Task, {bool isEditMode}) addNewTask;
  final TaskGroup taskGroup;
  final Task taskToBeEdited;
  final bool isEditMode;
  AddTaskWidget({
    @required this.taskGroup,
    @required this.addNewTask,
    @required this.isEditMode,
    @required this.taskToBeEdited,
  });
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  double _rating = 2.0;
  bool _hasError = false;
  TextEditingController _taskNameController;
  @override
  void initState() {
    _taskNameController = TextEditingController(
        text: widget.isEditMode ? widget.taskToBeEdited.taskName : null);
    if (widget.isEditMode) {
      _rating = (widget.taskToBeEdited.difficulty.index + 1).toDouble();
    }
    super.initState();
  }

  void addTask() {
    setState(() {
      _hasError = false;
    });
    if (_taskNameController.text.trim().isEmpty) {
      setState(() {
        _hasError = true;
      });
      return;
    }
    Difficulty diff;
    switch (_rating.toInt()) {
      case 1:
        diff = Difficulty.Easy;
        break;
      case 3:
        diff = Difficulty.Hard;
        break;
      default:
        diff = Difficulty.Medium;
    }
    if (widget.isEditMode) {
      Task task = widget.taskToBeEdited;
      task
        ..difficulty = diff
        ..taskName = _taskNameController.text.trim();
      //! we need to call this to reset the state
      widget.addNewTask(null, isEditMode: true);
    } else {
      widget.addNewTask(
          Task(taskName: _taskNameController.text.trim(), difficulty: diff));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 250,
        child: Stack(
          children: [
            Positioned(
                top: -10,
                right: -10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.cancel,
                      size: 25,
                      color: widget.taskGroup.taskGroupColor[
                          Theme.of(context).brightness == Brightness.dark
                              ? 200
                              : 600]),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text('Task Name', style: Theme.of(context).textTheme.headline3),
                TextField(
                    controller: _taskNameController,
                    cursorColor: widget.taskGroup.taskGroupColor[200],
                    decoration: InputDecoration(
                        errorText: _hasError ? 'Enter task name' : null,
                        border: InputBorder.none,
                        labelText: 'Type task name...',
                        labelStyle: Constants.coloredLabelTextStyle(
                            widget.taskGroup.taskGroupColor[
                                Theme.of(context).brightness == Brightness.dark
                                    ? 200
                                    : 600]))),
                Text('Difficulty',
                    style: Theme.of(context).textTheme.headline3),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  maxRating: 3,
                  itemBuilder: (ctx, index) => Icon(Icons.star,
                      color: widget.taskGroup.taskGroupColor[500]),
                  itemCount: 3,
                  onRatingUpdate: (x) => setState(() {
                    _rating = x;
                  }),
                  glow: true,
                  glowColor: Colors.red,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      //width: 150,
                      height: 33,
                      child: CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          child: Text(widget.isEditMode ? 'Edit' : 'Add',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: addTask,
                          color: widget.taskGroup.taskGroupColor[600])),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
