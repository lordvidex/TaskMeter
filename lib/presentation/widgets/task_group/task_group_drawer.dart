import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/domain/models/task.dart';

import '../../providers/authentication_provider.dart';
import '../../providers/task_group_provider.dart';

class TaskGroupDrawer extends StatelessWidget {
  List<Widget> headerAndBody(String headerText, String bodyText) {
    return [
      Text(headerText, style: TextStyle(fontWeight: FontWeight.bold)),
      Text('\t$bodyText')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      child: Consumer<TaskGroupProvider>(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Your TaskGroups Overview:'),
        ),
        builder: (contx, tGProvider, child) {
          final taskGroups = tGProvider.taskGroups;
          final completedTaskGroups = tGProvider.taskGroups.fold<int>(
              0, (last, tg) => last + (tg.taskGroupProgress == 1 ? 1 : 0));
          final tasks = taskGroups.fold<List<Task>>([], (oldList, element) {
            element.tasks.forEach((t) => oldList.add(t));
            return oldList;
          });
          final completedTasks = tasks.fold<int>(
              0, (last, task) => last + (task.isCompleted ? 1 : 0));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child,
              ...headerAndBody(
                  'Current TaskGroups: ', taskGroups.length.toString()),
              ...headerAndBody(
                  'Completed TaskGroups: ', completedTaskGroups.toString()),
              ...headerAndBody('Current Tasks: ', tasks.length.toString()),
              ...headerAndBody('Completed Tasks: ', completedTasks.toString()),
            ],
          );
        },
      ),
      builder: (ctx, authProvider, child) => Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            Text('Welcome ${authProvider.user?.displayName}'),
            child,
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //TODO: add share
                },
                child: Text('Share TaskMeter with Friends',
                    style: TextStyle(color: Colors.blue))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  authProvider.logOut();
                },
                child: Text('Log Out', style: TextStyle(color: Colors.red)))
          ]),
        ),
      ),
    );
  }
}