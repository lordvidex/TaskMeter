import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../core/utils/color_utils.dart';
import 'task.dart';

class TaskGroup extends Equatable {
  final String taskGroupId;

  ///name of the group of tasks
  String taskGroupName;

  /// description of the taskGroup
  final String taskGroupSubtitle;

  /// total time user plans to finish the task
  Duration totalTime;

  /// color assigned in TaskGroup
  final MaterialColor taskGroupColor;

  /// list of tasks to complete
  List<Task> tasks;

  /// number of tasks before a long break
  int longBreakIntervals;

  /// [Duration] short break time
  Duration longBreakTime;

  /// [Duration] long break time
  Duration shortBreakTime;

  ///Bonus time - residual time for tasks finished on time
  Duration bonusTime;

  /// is `true` if user wants to repeat the task periodically\
  /// is `false` if it is a one-time group of tasks
  final bool isRepetitive;

  TaskGroup(
    this.taskGroupName, {
    this.taskGroupSubtitle = '',
    this.isRepetitive = false,
    this.longBreakTime,
    this.shortBreakTime,
    this.longBreakIntervals,
    this.totalTime,
    this.bonusTime = Duration.zero,
  })  : taskGroupId = Uuid().v1(),
        tasks = <Task>[],
        taskGroupColor = ColorUtils.randomColor();

  int get completedCount => tasks.fold<int>(
      0, (prev, element) => prev + (element.isCompleted ? 1 : 0));
  List<Task> get sortedTasks => List.from(tasks)
    ..sort((t1, t2) {
      if (t1.isCompleted) return 1;
      if (t2.isCompleted) return -1;
      return t1.taskProgress.compareTo(t2.taskProgress) * -1;
    });
  double get taskGroupProgress =>
      completedCount / (tasks.isEmpty ? 1 : tasks.length);
  @override
  List<Object> get props => [taskGroupId];
}
