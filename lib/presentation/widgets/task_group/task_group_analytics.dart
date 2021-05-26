import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/domain/models/task.dart';
import 'package:task_meter/presentation/bloc/size_bloc.dart';

import '../../providers/authentication_provider.dart';
import '../../providers/task_group_provider.dart';

class TaskGroupAnalytics extends StatelessWidget {
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
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child,
                ...headerAndBody(
                    'Current TaskGroups: ', taskGroups.length.toString()),
                ...headerAndBody(
                    'Completed TaskGroups: ', completedTaskGroups.toString()),
                ...headerAndBody('Current Tasks: ', tasks.length.toString()),
                ...headerAndBody(
                    'Completed Tasks: ', completedTasks.toString()),
              ],
            ),
          );
        },
      ),
      builder: (ctx, authProvider, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          if (ctx.read<SizeBloc>().isMobileScreen)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () => Navigator.of(context).pop()),
            ),
          Image.asset(
            'assets/images/task_app.png',
            height: 60,
          ),
          //Text('Welcome ${authProvider.user?.displayName ?? 'Anonymous'}'),
          child,
          Spacer(),
          TextButton(
              onPressed: () {
                if (context.read<SizeBloc>().isMobileScreen)
                  Navigator.of(context).pop();
                //TODO: add share
              },
              child: Text('Share TaskMeter with Friends',
                  style: TextStyle(color: Colors.blue))),
          TextButton(
              onPressed: () async {
                if (context.read<SizeBloc>().isMobileScreen)
                  Navigator.of(context).pop();
                await authProvider.logOut();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Log out successful!')));
              },
              child: Text('Log Out', style: TextStyle(color: Colors.red)))
        ]),
      ),
    );
  }
}
