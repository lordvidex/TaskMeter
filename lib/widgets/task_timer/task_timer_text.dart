import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/locale/locales.dart';

import '../../bloc/timer_bloc.dart';
import '../../core/utils/duration_utils.dart';
import '../../models/task.dart';
import '../../providers/task_group_provider.dart';
import '../../screens/task_timer_screen.dart';

class TaskTimerText extends StatelessWidget {
  final BuildContext parentContext;
  final Task task;
  final int timerStateOverTen;
  final Function(int) updateBoardImageWithNumber;
  final Function() onTimerFinished;

  const TaskTimerText(
    this.parentContext,
    this.task,
    this.timerStateOverTen, {
    @required this.updateBoardImageWithNumber,
    this.onTimerFinished,
  });
  void onCancelPressed(TaskGroupProvider provider, BuildContext dialogContext) {
    if (provider.isBreak) provider.toggleBreak();
    Navigator.of(dialogContext).pop();
    Navigator.of(parentContext).pop();
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
    Task breakTask = Task(
        taskName: provider.isLongBreak
            ? AppLocalizations.of(dialogContext).longBreak
            : AppLocalizations.of(dialogContext).shortBreak)
      ..setTotalTime(provider.isLongBreak
          ? provider.currentTaskGroup.longBreakTime
          : provider.currentTaskGroup.shortBreakTime);
    Navigator.of(dialogContext).pop();
    Navigator.of(parentContext)
        .pushReplacementNamed(TaskTimerScreen.routeName, arguments: breakTask);
  }

  void onNextTask(
      TaskGroupProvider provider, TimerBloc bloc, BuildContext dialogContext) {
    if (provider.isBreak) provider.toggleBreak();
    final nextUndoneTask = provider.currentTaskGroup.sortedTasks[0];
    Navigator.of(dialogContext).pop();
    Navigator.of(parentContext).pushReplacementNamed(TaskTimerScreen.routeName,
        arguments: nextUndoneTask);
  }

  Future showTaskFinishedDialog(
      BuildContext context, TaskGroupProvider provider, TimerBloc bloc) {
    final appLocale = AppLocalizations.of(context);
    return showCupertinoDialog(
        context: context,
        //barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (ctx) {
          Duration bonusDuration = provider.currentTaskGroup.bonusTime;
          return CupertinoAlertDialog(
              title: Text('${appLocale.youHaveFinished}'
                  ' ${provider.isBreak ? appLocale.breakLabel : (appLocale.task + " ${task.taskName}")}'),
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
                if (!provider.isBreak &&
                    (provider.isLongBreak
                        ? provider.currentTaskGroup.longBreakTime !=
                            Duration.zero
                        : provider.currentTaskGroup.shortBreakTime !=
                            Duration.zero))
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
      if (state is TimerRunning) {
        // Break time and
        final liveTimeQuotient =
            DurationUtils.liveDurationQuotient(state.duration, task.totalTime);
        if (liveTimeQuotient != timerStateOverTen) {
          updateBoardImageWithNumber(liveTimeQuotient);
        }
      } else {
        if (!provider.isBreak) provider.updateTaskTime(task, state.duration);
        if (state is TimerFinished) {
          onTimerFinished();
          final taskGroup = provider.currentTaskGroup;
          // add residual time to bonus time for the group task and mark task as done
          if (state.duration != Duration.zero) {
            if (!provider.isBreak) provider.updateTaskTime(task, Duration.zero);
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
      return Text('${DurationUtils.durationToClockString(state.duration)}',
          style: Theme.of(context).textTheme.headline1);
    });
  }
}
