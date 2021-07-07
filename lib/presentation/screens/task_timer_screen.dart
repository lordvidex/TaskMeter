import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_meter/core/utils/duration_utils.dart';
import 'package:task_meter/locale/locales.dart';
import 'package:task_meter/presentation/widgets/task_timer/action_button.dart';
import 'package:task_meter/presentation/widgets/task_timer/mosquito_widget.dart';
import 'package:wakelock/wakelock.dart';

import '../bloc/timer_bloc.dart';
import '../../domain/models/task.dart';
import '../providers/task_group_provider.dart';

class TaskTimerScreen extends StatefulWidget {
  static const routeName = '/task-timer';
  @override
  _TaskTimerScreenState createState() => _TaskTimerScreenState();
}

class _TaskTimerScreenState extends State<TaskTimerScreen> {
  Task task;
  bool _isPaused;
  bool _isFinished;
  double backDropFilter;
  MosquitoWidgetController controller;

  @override
  void initState() {
    Wakelock.enable();

    _isPaused = false;
    _isFinished = false;
    controller = MosquitoWidgetController();
    if (task != null)
      context.read<TimerBloc>().add(TimerStartEvent(task.timeRemaining));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
  }

  void saveTaskStatus(BuildContext context) {
    final duration = context.read<TimerBloc>().state.duration;
    context.read<TaskGroupProvider>().updateTaskTime(task, duration);
  }

  @override
  Widget build(BuildContext context) {
    final taskGroupProvider = context.read<TaskGroupProvider>();
    final size = MediaQuery.of(context).size;
    if (task == null) {
      task = ModalRoute.of(context).settings.arguments as Task;
      context.read<TimerBloc>().add(TimerStartEvent(task.timeRemaining));
    }
    //! Debug
    if (task == null) {
      task = new Task()..setTotalTime(Duration(seconds: 60));
    }
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      backDropFilter = 70.0;
    } else {
      backDropFilter = 40.0;
    }
    return WillPopScope(
      onWillPop: () {
        saveTaskStatus(context);
        return Future.value(true);
      },
      child: Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: 22,
              right: 10,
              child: MosquitoWidget(
                controller: controller,
                lowerBoundX: size.width - 10 - 250,
                lowerBoundY: 22,
                upperBoundX: 10,
                upperBoundY: size.height - 22 - 250,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(203, 224, 255, 0.71),
                  ),
                ),
              )),
          Positioned(
              bottom: 251,
              left: -29,
              child: MosquitoWidget(
                fasterX: false,
                controller: controller,
                upperBoundX: size.width,
                lowerBoundX: 0,
                upperBoundY: 251,
                lowerBoundY: 501 - size.height,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(203, 255, 208, 0.71),
                      shape: BoxShape.circle),
                  width: 250,
                  height: 250,
                ),
              )),
          Positioned(
              bottom: 0,
              right: -29,
              child: MosquitoWidget(
                upperBoundX: -29,
                upperBoundY: 0,
                lowerBoundX: -size.width - 29,
                lowerBoundY: -size.height,
                controller: controller,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 203, 203, 0.71),
                      shape: BoxShape.circle),
                  width: 250,
                  height: 250,
                ),
              )),
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: backDropFilter,
                sigmaY: backDropFilter,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocConsumer<TimerBloc, TimerState>(
                    listenWhen: (fromState, toState) =>
                        fromState is! TimerRunning || toState is! TimerRunning,
                    listener: (ctx, state) {
                      final taskGroup = taskGroupProvider.currentTaskGroup;
                      if (!taskGroupProvider.isBreak)
                        taskGroupProvider.updateTaskTime(task, state.duration);
                      if (state is TimerFinished) {
                        controller.pause();
                        setState(() {
                          _isFinished = true;
                        });
                        // add residual time to bonus time for the group task and mark task as done
                        if (state.duration != Duration.zero) {
                          if (!taskGroupProvider.isBreak)
                            taskGroupProvider.updateTaskTime(
                                task, Duration.zero);
                          taskGroupProvider.updateBonusTime(
                              duration: state.duration);
                        }
                        if (taskGroup.taskGroupProgress == 1) {
                          // all tasks are finished
                          Navigator.of(context).pop();
                        }
                      } else if (state is TimerPaused || state is TimerReady) {
                        controller.pause();
                      } else {
                        controller.resume();
                      }
                    },
                    builder: (ctx, state) => state is TimerFinished
                        ? CircularPercentIndicator(
                            lineWidth: 3,
                            radius: 234,
                            percent: 1,
                            animation: false,
                            progressColor: Color(0xff62C370),
                            center: SvgPicture.asset(
                              'assets/icons/check.svg',
                              width: 117,
                              height: 76.5,
                            ))
                        : CircularPercentIndicator(
                            radius: 300,
                            reverse: true,
                            percent: state.duration.inMilliseconds /
                                task.totalTime.inMilliseconds,
                            lineWidth: 3,
                            backgroundColor: Colors.transparent,
                            linearGradient: LinearGradient(
                                colors: isDarkMode
                                    ? [
                                        Colors.white,
                                        Color.fromRGBO(229, 229, 229, 0.49)
                                      ]
                                    : [
                                        Color(0xff425094),
                                        Color.fromRGBO(29, 37, 84, 0.5),
                                      ]),
                            center: Text(
                              DurationUtils.durationToClockString(
                                  state.duration),
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xffFDFEFE)
                                      : Color.fromRGBO(29, 37, 84, 1),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 70,
                                  fontFamily: 'Circular-Std'),
                            ),
                          ),
                  ),
                  Text(
                      !_isFinished
                          ? task.taskName
                          : taskGroupProvider.isBreak
                              ? 'Break Complete'
                              : 'Task Complete',
                      style: TextStyle(
                          fontFamily: 'Circular-Std',
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  !_isFinished
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ActionButton(
                              onPressed: () {
                                _isPaused = !_isPaused;
                                context.read<TimerBloc>().add(_isPaused
                                    ? TimerPauseEvent()
                                    : TimerResumeEvent());
                                setState(() {});
                              },
                              filled: !_isPaused,
                              color: Color.fromRGBO(195, 98, 98, 1),
                              text: _isPaused ? 'Resume' : 'Pause',
                              icon: SvgPicture.asset(
                                'assets/icons/${_isPaused ? 'play' : 'pause'}.svg',
                                height: _isPaused ? 18 : 14,
                                width: _isPaused ? 18 : 10,
                              ),
                            ),
                            ActionButton(
                              onPressed: () {
                                context
                                    .read<TimerBloc>()
                                    .add(TimerFinishEvent());
                              },
                              color: Color(0xff62C370),
                              text: 'Complete',
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (!taskGroupProvider.isBreak)
                              ActionButton(
                                onPressed: () {
                                  if (!taskGroupProvider.isBreak)
                                    taskGroupProvider.toggleBreak();
                                  task = Task(
                                      taskName: taskGroupProvider.isLongBreak
                                          ? AppLocalizations.of(context)
                                              .longBreak
                                          : AppLocalizations.of(context)
                                              .shortBreak)
                                    ..setTotalTime(taskGroupProvider.isLongBreak
                                        ? taskGroupProvider
                                            .currentTaskGroup.longBreakTime
                                        : taskGroupProvider
                                            .currentTaskGroup.shortBreakTime);
                                  setState(() {
                                    _isFinished = false;
                                    context.read<TimerBloc>().add(
                                        TimerStartEvent(task.timeRemaining));
                                  });
                                },
                                color: Color.fromRGBO(195, 98, 98, 1),
                                text: 'Take Break',
                              ),
                            ActionButton(
                              wide: taskGroupProvider.isBreak,
                              onPressed: () {
                                if (taskGroupProvider.isBreak)
                                  taskGroupProvider.toggleBreak();
                                setState(() {
                                  task = taskGroupProvider
                                      .currentTaskGroup.sortedTasks[0];
                                  _isFinished = false;
                                });
                                context
                                    .read<TimerBloc>()
                                    .add(TimerStartEvent(task.timeRemaining));
                              },
                              color: Color(0xff62C370),
                              text: 'Next Task',
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
          Positioned(
              top: 36,
              left: 0,
              child: TextButton(
                  onPressed: () {
                    saveTaskStatus(context);
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset('assets/icons/back.svg',
                      width: 29, height: 24))),
        ],
      )),
    );
  }
}
