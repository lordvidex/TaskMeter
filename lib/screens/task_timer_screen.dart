import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:task_meter/bloc/timer_bloc.dart';

import '../core/errors.dart';
import '../models/task.dart';
import '../widgets/task_timer_widget.dart';
import 'error_screen.dart';

class TaskTimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context).settings.arguments as Task;
    if (task == null) {
      task = new Task()..setTotalTime(Duration(seconds: 60));
      Navigator.of(context).pushReplacementNamed(ErrorScreen.routeName,
          arguments: ErrorStrings.emptyTaskTimer);
    }
    return BlocProvider(
        create: (_) => GetIt.I<TimerBloc>(),
        child: Scaffold(
            body: Stack(children: [
          TaskTimerWidget(task),
          TaskLabelWidget(task),
        ])));
  }
}

class TaskLabelWidget extends StatelessWidget {
  final Task task;

  const TaskLabelWidget(this.task);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Text(task.taskName, style: Theme.of(context).textTheme.headline2),
    ));
  }
}
