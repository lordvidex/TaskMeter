import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/models/task.dart';
import 'package:task_meter/models/task_group.dart';

void main() {
  TaskGroup taskGroup;
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
}
