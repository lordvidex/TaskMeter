import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timer_bloc.dart';
import '../models/task.dart';

class TaskTimerWidget extends StatefulWidget {
  final Task task;
  TaskTimerWidget(this.task);
  @override
  _TaskTimerWidgetState createState() => _TaskTimerWidgetState();
}

class _TaskTimerWidgetState extends State<TaskTimerWidget> {
  double getProgress(Duration current) {
    assert(current != null && widget.task != null);
    return current.inMilliseconds / widget.task.totalTime.inMilliseconds;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimerBloc>(context)
        .add(TimerStartEvent(widget.task.timeRemaining));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<TimerBloc, TimerState>(builder: (ctx, state) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
              child: Text('${state.duration.inSeconds}',
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
