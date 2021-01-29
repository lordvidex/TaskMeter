import 'package:equatable/equatable.dart';

import 'task.dart';
import 'package:uuid/uuid.dart';

class TaskGroup extends Equatable {
  final String taskGroupId;
  //name of the group of tasks
  final String taskGroupName;
  // total time user plans to finish the task
  Duration totalTime;
  // list of tasks to complete
  List<Task> tasks;
  // is `true` if user wants to repeat the task periodically
  //is `false` if it is a one-time group of tasks
  final bool isRepetitive;

  TaskGroup(
    this.taskGroupName, {
    this.isRepetitive = false,
  })  : taskGroupId = Uuid().v1(),
        tasks = <Task>[];

  @override
  List<Object> get props => [taskGroupId];
}
