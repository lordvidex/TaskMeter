import 'package:flutter/material.dart';

import '../models/task_group.dart';
import '../widgets/task_group_description/header_container_widget.dart';
import '../widgets/task_group_description/task_card.dart';

class TaskGroupDescriptionScreen extends StatelessWidget {
  static const routeName = '/task-group-description';
  @override
  Widget build(BuildContext context) {
    var taskGroup = ModalRoute.of(context).settings.arguments as TaskGroup;
    //! Debug
    if (taskGroup == null) {
      taskGroup = new TaskGroup('Finish Homework');
    }
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Flexible(
            flex: 3,
            child: HeaderContainerWidget(taskGroup: taskGroup),
          ),
          Flexible(
              flex: 7,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return TaskCard(
                      taskGroup: taskGroup, task: taskGroup.tasks[index]);
                },
                itemCount: taskGroup.tasks.length,
              ))
        ],
      )),
    );
  }
}
