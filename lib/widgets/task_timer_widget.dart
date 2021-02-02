import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/core/utils/duration_utils.dart';
import 'package:task_meter/providers/task_group_provider.dart';

import '../bloc/timer_bloc.dart';
import '../models/task.dart';

class TaskTimerWidget extends StatefulWidget {
  final Task task;
  TaskTimerWidget(this.task);
  @override
  _TaskTimerWidgetState createState() => _TaskTimerWidgetState();
}

class _TaskTimerWidgetState extends State<TaskTimerWidget> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimerBloc>(context)
        .add(TimerStartEvent(widget.task.timeRemaining));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerBloc, TimerState>(listener: (ctx, state) {
      if (state is! TimerRunning) {
        Provider.of<TaskGroupProvider>(context, listen: false)
            .updateTaskTime(widget.task, state.duration);
        if (state is TimerFinished) {
          final taskGroup =
              Provider.of<TaskGroupProvider>(context, listen: false)
                  .currentTaskGroup;
          if (taskGroup.taskGroupProgress == 1) {
            // all tasks are finished
            Navigator.of(context).pop();
          }
          //! if it is a task that was just finished
          //! 1. start a break (short/long) depending on tasks done
          //! 2. start the next task
          //! else if it is a break -> start the next task 
        }
      }
    }, builder: (ctx, state) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
              child: Text(
                  '${DurationUtils.durationToClockString(state.duration)}',
                  style: Theme.of(context).textTheme.headline2)),
          Positioned(
              bottom: 20,
              child: Row(children: [
                if (!(state is TimerFinished))
                  FlatButton(
                    color: Colors.blue,
                    shape: CircleBorder(),
                    height: 70,
                    child: (state is TimerPaused)
                        ? Icon(Icons.play_arrow)
                        : Icon(Icons.pause),
                    onPressed: () {
                      BlocProvider.of<TimerBloc>(context).add(
                          (state is TimerPaused)
                              ? TimerResumeEvent()
                              : TimerPauseEvent());
                    },
                  ),
                FlatButton(
                    child: Icon(Icons.check),
                    onPressed: () {},
                    color: Colors.green,
                    height: 70,
                    shape: CircleBorder()),
              ]))
        ],
      );
    });
  }
}
