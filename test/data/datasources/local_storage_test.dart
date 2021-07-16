import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_meter/data/datasources/local_storage.dart';
import 'package:task_meter/domain/models/task.dart';
import 'package:task_meter/domain/models/task_group.dart';
import 'package:uuid/uuid.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  SharedPreferencesMock mock;
  LocalStorageImpl localStorage;
  setUp(() {
    mock = SharedPreferencesMock();
    localStorage = LocalStorageImpl(sharedPreferences: mock);
  });
  group('Fetching Data from local storage', () {
    final longBreak = Duration(minutes: 1);
    final shortBreak = Duration.zero;
    final id = Uuid().v1();
    final id2 = Uuid().v1();
    final subtitle = 'My subtitle';
    final tasks = List.generate(3, (x) => Task(taskName: 'Task $x'));
    final totalTime = Duration(minutes: 30);
    test(
        'should be properly encoded and decoded using json.encode() and json.decode()',
        () async {
      // arrange
      final storedList = [
        json.encode({
          'task_group_name': 'First',
          'bonus_time': 0,
          'is_repetitive': false,
          'long_break_intervals': 2,
          'long_break_time': longBreak.inSeconds,
          'short_break_time': shortBreak.inSeconds,
          'task_group_id': id,
          'task_group_subtitle': subtitle,
          'tasks': tasks.map((t) => t.toJson()).toList(),
          'total_time': totalTime.inSeconds,
        }),
        json.encode({
          'task_group_name': 'Second',
          'bonus_time': 0,
          'is_repetitive': false,
          'long_break_intervals': 2,
          'long_break_time': longBreak.inSeconds,
          'short_break_time': shortBreak.inSeconds,
          'task_group_id': id2,
          'task_group_subtitle': subtitle,
          'tasks': tasks.map((t) => t.toJson()).toList(),
          'total_time': totalTime.inSeconds,
        })
      ];
      final expectedTaskGroups = [
        TaskGroup('First',
            bonusTime: Duration.zero,
            isRepetitive: false,
            longBreakIntervals: 2,
            longBreakTime: longBreak,
            shortBreakTime: shortBreak,
            taskGroupId: id,
            taskGroupSubtitle: subtitle,
            tasks: tasks,
            totalTime: totalTime),
        TaskGroup('Second',
            bonusTime: Duration.zero,
            isRepetitive: false,
            longBreakIntervals: 2,
            longBreakTime: longBreak,
            shortBreakTime: shortBreak,
            taskGroupId: id2,
            taskGroupSubtitle: subtitle,
            tasks: tasks,
            totalTime: totalTime)
      ];
      when(mock.containsKey(any)).thenReturn(true);
      when(mock.getStringList(any)).thenReturn(storedList);
      // act
      final list = await localStorage.fetchTaskGroups();
      // assert
      expect(list, expectedTaskGroups);
    });
  });
}
