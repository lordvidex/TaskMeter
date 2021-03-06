import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_group_provider.dart';
import '../widgets/task_group_description/header_container_widget.dart';
import '../widgets/task_group_description/task_card.dart';

class TaskGroupDescriptionScreen extends StatelessWidget {
  static const routeName = '/task-group-description';
  @override
  Widget build(BuildContext context) {
    var taskGroup = context.watch<TaskGroupProvider>().currentTaskGroup;
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: taskGroup.taskGroupColor[800],
        ),
        body: Container(
          //color: taskGroup.taskGroupColor[800],
          child: Column(
            children: [
              HeaderContainerWidget(taskGroup: taskGroup),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return TaskCard(
                        taskGroup: taskGroup,
                        task: taskGroup.sortedTasks[index]);
                  },
                  itemCount: taskGroup.tasks.length,
                ),
              )
            ],
          ),
        ));
  }
}
