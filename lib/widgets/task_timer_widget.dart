import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/timer_bloc.dart';
import '../core/utils/duration_utils.dart';
import '../models/task.dart';
import '../providers/task_group_provider.dart';
import '../screens/task_timer_screen.dart';

class TaskTimerWidget extends StatefulWidget {
  Task task;
  final BuildContext parentContext;
  TaskTimerWidget(this.task, this.parentContext);
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

  void onCancelPressed(TaskGroupProvider provider, BuildContext dialogContext) {
    if (provider.isBreak) provider.toggleBreak();
    Navigator.of(dialogContext).pop();
    Navigator.of(widget.parentContext).pop();
  }

  void onBonusPressed({
    @required TaskGroupProvider provider,
    @required TimerBloc bloc,
    @required BuildContext dialogContext,
    @required Duration bonusDuration,
  }) {
    provider.updateBonusTime(reset: true);

    bloc.add(TimerStartEvent(bonusDuration));
    Navigator.of(dialogContext).pop();
  }

  void onBreakPressed(
      TaskGroupProvider provider, TimerBloc bloc, BuildContext dialogContext) {
    if (!provider.isBreak) provider.toggleBreak();
    int remainder = provider.currentTaskGroup.completedCount %
        provider.currentTaskGroup.longBreakIntervals;
    Task breakTask =
        Task(taskName: '${remainder == 0 ? 'Long' : 'Short'} Break')
          ..setTotalTime(remainder == 0
              ? provider.currentTaskGroup.longBreakTime
              : provider.currentTaskGroup.shortBreakTime);
    Navigator.of(dialogContext).pop();
    Navigator.of(widget.parentContext)
        .pushReplacementNamed(TaskTimerScreen.routeName, arguments: breakTask);
  }

  void onNextTask(
      TaskGroupProvider provider, TimerBloc bloc, BuildContext dialogContext) {
    if (provider.isBreak) provider.toggleBreak();
    final nextUndoneTask = provider.currentTaskGroup.sortedTasks[0];
    Navigator.of(dialogContext).pop();
    Navigator.of(widget.parentContext).pushReplacementNamed(
        TaskTimerScreen.routeName,
        arguments: nextUndoneTask);
  }

  Future showTaskFinishedDialog(
      BuildContext context, TaskGroupProvider provider, TimerBloc bloc) {
    return showCupertinoDialog(
        context: context,
        //barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (ctx) {
          Duration bonusDuration = provider.currentTaskGroup.bonusTime;
          return CupertinoAlertDialog(
              title: Text(
                  'You have finished ${provider.isBreak ? 'Break' : 'Task "${widget.task.taskName}"'}'),
              content: Text('Where to next?'),
              actions: [
                CupertinoDialogAction(
                    child: Text('Cancel'),
                    isDestructiveAction: true,
                    onPressed: () => onCancelPressed(provider, ctx)),
                if (!provider.isBreak && bonusDuration == Duration.zero)
                  CupertinoDialogAction(
                      child: Text('Use Bonus'),
                      onPressed: () => onBonusPressed(
                          provider: provider,
                          bloc: bloc,
                          dialogContext: ctx,
                          bonusDuration: bonusDuration)),
                if (!provider.isBreak)
                  CupertinoDialogAction(
                    child: Text('Take Break'),
                    isDefaultAction: true,
                    onPressed: () => onBreakPressed(provider, bloc, ctx),
                  ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Next Task'),
                  onPressed: () => onNextTask(provider, bloc, ctx),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerBloc, TimerState>(listener: (ctx, state) {
      final provider = Provider.of<TaskGroupProvider>(context, listen: false);
      final bloc = BlocProvider.of<TimerBloc>(context);
      if (state is! TimerRunning) {
        if (!provider.isBreak)
          provider.updateTaskTime(widget.task, state.duration);
        if (state is TimerFinished) {
          final taskGroup = provider.currentTaskGroup;
          // add residual time to bonus time for the group task and mark task as done
          if (state.duration != Duration.zero) {
            if (!provider.isBreak)
              provider.updateTaskTime(widget.task, Duration.zero);
            provider.updateBonusTime(duration: state.duration);
          }

          if (taskGroup.taskGroupProgress == 1) {
            // all tasks are finished
            Navigator.of(context).pop();
          } else {
            //! if it is a task that was just finished
            //! 1. start a break (short/long) depending on tasks done
            //! 2. start the next task
            //! else if it is a break -> start the next task
            showTaskFinishedDialog(context, provider, bloc);
          }
        }
      }
      //bloc.close();
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
                    onPressed: () => BlocProvider.of<TimerBloc>(context)
                        .add(TimerFinishEvent()),
                    color: Colors.green,
                    height: 70,
                    shape: CircleBorder()),
              ]))
        ],
      );
    });
  }
}
