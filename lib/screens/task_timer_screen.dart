import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/providers/task_group_provider.dart';

import '../bloc/timer_bloc.dart';
import '../models/task.dart';
import '../widgets/task_timer_widget.dart';

class TaskTimerScreen extends StatefulWidget {
  static const routeName = '/task-timer';

  @override
  _TaskTimerScreenState createState() => _TaskTimerScreenState();
}

class _TaskTimerScreenState extends State<TaskTimerScreen> {
  Task task;
  @override
  Widget build(BuildContext context) {
    if (task == null) task = ModalRoute.of(context).settings.arguments as Task;
    //! Debug
    if (task == null) {
      task = new Task()..setTotalTime(Duration(seconds: 60));
      // Navigator.of(context).pushReplacementNamed(ErrorScreen.routeName,
      //     arguments: ErrorStrings.emptyTaskTimer);
    }
    return BlocProvider(
        create: (_) => GetIt.I<TimerBloc>(),
        child: Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Stack(children: [
              TaskTimerWidget(task, context),
              TaskLabelWidget(task, context),
            ]),
          ),
        )));
  }
}

class TaskLabelWidget extends StatelessWidget {
  final Task task;
  final BuildContext parentContext;

  const TaskLabelWidget(this.task, this.parentContext);
  void _back(BuildContext context) {
    final duration = BlocProvider.of<TimerBloc>(context).state.duration;
    Provider.of<TaskGroupProvider>(context, listen: false)
        .updateTaskTime(task, duration);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _back(context);
        return Future.value(true);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: IconButton(
                icon: Icon(CupertinoIcons.back, size: 44, color: Colors.black),
                onPressed: () => _back(context)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10),
            child: Text(task.taskName,
                style: Theme.of(context).textTheme.headline2),
          ),
        ],
      ),
    );
  }
}
