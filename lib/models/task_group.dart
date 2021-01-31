import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../core/utils/color_utils.dart';
import 'task.dart';

class TaskGroup extends Equatable {
  final String taskGroupId;

  //name of the group of tasks
  final String taskGroupName;

  // description of the taskGroup
  final String taskGroupSubtitle;

  // total time user plans to finish the task
  Duration totalTime;

  // color assigned in TaskGroup
  final MaterialColor taskGroupColor;

  // list of tasks to complete
  List<Task> tasks;
  // is `true` if user wants to repeat the task periodically
  //is `false` if it is a one-time group of tasks
  final bool isRepetitive;

  TaskGroup(
    this.taskGroupName, {
    this.taskGroupSubtitle = '',
    this.isRepetitive = false,
  })  : taskGroupId = Uuid().v1(),
        tasks = <Task>[],
        taskGroupColor = ColorUtils.randomColor();

  double get taskGroupProgress =>
      tasks.fold<int>(
          0, (prev, element) => prev + (element.isCompleted ? 1 : 0)) /
      (tasks.isEmpty ? 1 : tasks.length);
  @override
  List<Object> get props => [taskGroupId];
}
