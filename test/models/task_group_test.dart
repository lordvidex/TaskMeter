import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/core/utils/color_utils.dart';
import 'package:task_meter/domain/models/task.dart';
import 'package:task_meter/domain/models/task_group.dart';
import 'package:uuid/uuid.dart';

void main() {
  TaskGroup taskGroup;

  //* values used in fromJson() and toJson() tests
  final taskGroupName = 'My Task Group';
  final color = Colors.red;
  final longBreak = Duration(minutes: 1);
  final shortBreak = Duration.zero;
  final id = Uuid().v1();
  final subtitle = 'My subtitle';
  final tasks = List.generate(3, (x) => Task(taskName: 'Task $x'));
  final totalTime = Duration(minutes: 30);
  setUp(() {
    taskGroup = TaskGroup('TaskGroup 1');
  });
  test('should create an empty list of Tasks when a new task group is created',
      () {
    // assert
    expect(taskGroup.tasks, isEmpty);
  });
  test('should add task when tasks list "add" function is called', () {
    // act
    taskGroup.tasks.add(Task());
    // assert
    expect(taskGroup.tasks.length, equals(1));
  });
  group('Conversion toJson', () {
    final taskGroupName = 'My Task Group';
    final color = Colors.red;
    final longBreak = Duration(minutes: 1);
    final shortBreak = Duration.zero;
    final id = Uuid().v1();
    final subtitle = 'My subtitle';
    final tasks = List.generate(3, (x) => Task(taskName: 'Task $x'));
    final totalTime = Duration(minutes: 30);
    test('should successfully return a json map', () {
      // arrange

      final taskGroup = TaskGroup(taskGroupName,
          taskGroupColor: color,
          bonusTime: Duration.zero,
          isRepetitive: false,
          longBreakIntervals: 2,
          longBreakTime: longBreak,
          shortBreakTime: shortBreak,
          taskGroupId: id,
          taskGroupSubtitle: subtitle,
          tasks: tasks,
          totalTime: totalTime);
      final expectedJson = {
        'task_group_name': taskGroupName,
        ''
            'task_group_color': ColorUtils.getPositionOfMaterialColor(color),
        'bonus_time': 0,
        'is_repetitive': false,
        'time_of_upload': null,
        'long_break_intervals': 2,
        'long_break_time': longBreak.inSeconds,
        'short_break_time': shortBreak.inSeconds,
        'task_group_id': id,
        'task_group_subtitle': subtitle,
        'tasks': tasks.map((t) => t.toJson()).toList(),
        'total_time': totalTime.inSeconds,
      };
      // act
      final result = taskGroup.toJson();
      // assert
      expect(result, equals(expectedJson));
    });
    test(
        'should return valid json even when some fields are not provided in the constructor',
        () {
      // arrange

      final taskGroup = TaskGroup(taskGroupName,
          taskGroupColor: color,
          longBreakIntervals: 2,
          longBreakTime: longBreak,
          shortBreakTime: shortBreak,
          taskGroupId: id,
          tasks: tasks,
          totalTime: totalTime);
      final expectedJson = {
        'task_group_name': taskGroupName,
        'task_group_color': ColorUtils.getPositionOfMaterialColor(color),
        'bonus_time': 0,
        'time_of_upload': null,
        'is_repetitive': false,
        'long_break_intervals': 2,
        'long_break_time': longBreak.inSeconds,
        'short_break_time': shortBreak.inSeconds,
        'task_group_id': id,
        'task_group_subtitle': '',
        'tasks': tasks.map((t) => t.toJson()).toList(),
        'total_time': totalTime.inSeconds,
      };
      // act
      final result = taskGroup.toJson();
      // assert
      expect(result, equals(expectedJson));
    });
  });
  group('Conversion fromJson', () {
    test('should properly return TaskGroup when converted from json', () {
      final json = {
        'task_group_name': taskGroupName,
        'task_group_color': ColorUtils.getPositionOfMaterialColor(color),
        'bonus_time': 0,
        'is_repetitive': false,
        'long_break_intervals': 2,
        'long_break_time': longBreak.inSeconds,
        'short_break_time': shortBreak.inSeconds,
        'task_group_id': id,
        'task_group_subtitle': subtitle,
        'tasks': tasks.map((t) => t.toJson()).toList(),
        'total_time': totalTime.inSeconds,
      };
      // act
      final taskGroup = TaskGroup.fromJson(json);
      // assert
      expect(taskGroup.taskGroupId, id);
      expect(taskGroup.taskGroupName, taskGroupName);
      expect(taskGroup.taskGroupSubtitle, subtitle);
      expect(taskGroup.longBreakTime, longBreak);
      expect(taskGroup.shortBreakTime, shortBreak);
      expect(taskGroup.longBreakIntervals, 2);
      expect(taskGroup.tasks, tasks);
      expect(taskGroup.totalTime, totalTime);
      expect(taskGroup.taskGroupColor, color);
      expect(taskGroup.bonusTime, Duration.zero);
      expect(taskGroup.isRepetitive, isFalse);
    });
  });
}
