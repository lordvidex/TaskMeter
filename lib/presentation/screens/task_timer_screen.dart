import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_meter/presentation/widgets/task_timer/action_button.dart';
import 'package:wakelock/wakelock.dart';

import '../bloc/timer_bloc.dart';
import '../../domain/models/task.dart';
import '../providers/task_group_provider.dart';
import '../widgets/task_timer/task_timer_widget.dart';

class TaskTimerScreen extends StatefulWidget {
  static const routeName = '/task-timer';
  @override
  _TaskTimerScreenState createState() => _TaskTimerScreenState();
}

class _TaskTimerScreenState extends State<TaskTimerScreen> {
  Task task;
  double backDropFilter;

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    if (task == null) task = ModalRoute.of(context).settings.arguments as Task;
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
    return BlocProvider(
        create: (_) => GetIt.I<TimerBloc>(),
        child: Builder(
          builder: (context) {
            return Scaffold(
                body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                    top: 22,
                    right: 10,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(203, 224, 255, 0.71),
                      ),
                    )),
                Positioned(
                    bottom: 251,
                    left: -29,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(203, 255, 208, 0.71),
                          shape: BoxShape.circle),
                      width: 250,
                      height: 250,
                    )),
                Positioned(
                    bottom: 0,
                    right: -29,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 203, 203, 0.71),
                          shape: BoxShape.circle),
                      width: 250,
                      height: 250,
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
                        CircularPercentIndicator(
                          radius: 300,
                          percent: 0.9,
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
                            '14:24',
                            style: TextStyle(
                                color: Color.fromRGBO(29, 37, 84, 1),
                                fontWeight: FontWeight.w900,
                                fontSize: 70,
                                fontFamily: 'Circular-Std'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ActionButton(
                              onPressed: () {},
                              color: Color.fromRGBO(195, 98, 98, 1),
                              text: 'Pause',
                              icon: SvgPicture.asset(
                                'assets/icons/pause.svg',
                                height: 14,
                                width: 10,
                              ),
                            ),
                            ActionButton(
                              onPressed: () {},
                              color: Color(0xff62C370),
                              text: 'Complete',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
          },
        ));
  }
}
