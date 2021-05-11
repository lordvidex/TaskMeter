import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/color_utils.dart';
import 'task.dart';

class TaskGroup extends Equatable {
  String taskGroupId;

  ///name of the group of tasks
  String taskGroupName;

  /// description of the taskGroup
  final String taskGroupSubtitle;

  /// Time of upload to both database and server which is used
  /// to distinguish a current data from an old data.
  final DateTime timeOfUpload;

  /// total time user plans to finish the task
  Duration totalTime;

  /// color assigned in TaskGroup
  MaterialColor taskGroupColor;

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

  /// determines if task group has been deleted
  bool isDeleted;

  TaskGroup(
    this.taskGroupName, {
    this.timeOfUpload,
    String taskGroupId,
    List<Task> tasks,
    MaterialColor taskGroupColor,
    this.taskGroupSubtitle = '',
    this.isRepetitive = false,
    this.longBreakTime,
    this.shortBreakTime,
    this.longBreakIntervals,
    this.totalTime,
    bool isDeleted,
    this.bonusTime = Duration.zero,
  })  : this.taskGroupId = taskGroupId ?? Uuid().v1(),
        this.isDeleted = isDeleted ?? false,
        this.tasks = tasks ?? <Task>[],
        this.taskGroupColor = taskGroupColor ?? ColorUtils.randomColor();

  factory TaskGroup.fromJson(Map<String, dynamic> json) =>
      TaskGroup(json['task_group_name'],
          taskGroupId: json['task_group_id'],
          timeOfUpload: DateTime.tryParse(json['time_of_upload'] ?? ''),
          tasks: json['tasks']
              .map<Task>((taskJson) => Task.fromJson(taskJson))
              .toList(),
          taskGroupColor:
              ColorUtils.getMaterialColorInPos(json['task_group_color']),
          taskGroupSubtitle: json['task_group_subtitle'],
          isRepetitive: json['is_repetitive'],
          longBreakTime: json['long_break_time'] == null
              ? null
              : Duration(seconds: json['long_break_time']),
          shortBreakTime: json['short_break_time'] == null
              ? null
              : Duration(seconds: json['short_break_time']),
          longBreakIntervals: json['long_break_intervals'],
          totalTime: json['total_time'] == null
              ? null
              : Duration(seconds: json['total_time']),
          bonusTime: json['bonus_time'] == null
              ? null
              : Duration(seconds: json['bonus_time']),
          isDeleted: json['is_deleted']);

  /// In the database, the `taskGroupId` is the [key] and the `toJson` is the [value]
  /// * Durations are stored `inSeconds` in database
  Map<String, dynamic> toJson() {
    return {
      'time_of_upload': timeOfUpload?.toIso8601String(),
      'task_group_id': taskGroupId,
      'is_deleted': isDeleted,
      'task_group_name': taskGroupName,
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'task_group_subtitle': taskGroupSubtitle,
      'is_repetitive': isRepetitive,
      'long_break_time': longBreakTime?.inSeconds,
      'short_break_time': shortBreakTime?.inSeconds,
      'long_break_intervals': longBreakIntervals,
      'total_time': totalTime?.inSeconds,
      'bonus_time': bonusTime?.inSeconds,
      'task_group_color': ColorUtils.getPositionOfMaterialColor(taskGroupColor)
    };
  }

  void resetTasks() {
    tasks.forEach((t) => t.resetTask());
  }

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
