import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rive/rive.dart';

import '../../bloc/timer_bloc.dart';
import '../../../domain/models/task.dart';
import '../../../data/repositories/timer_repository.dart';
import 'task_timer_text.dart';

class TaskTimerWidget extends StatefulWidget {
  final Task task;
  final BuildContext parentContext;
  TaskTimerWidget(this.task, this.parentContext);
  @override
  _TaskTimerWidgetState createState() => _TaskTimerWidgetState();
}

class _TaskTimerWidgetState extends State<TaskTimerWidget> {
  int timerStateOverTen;
  Artboard _artboard;
  List<RiveFile> _sandClocks;
  SimpleAnimation _playAnimationController;
  //SimpleAnimation _idleController;
  Rive _rive;
  bool _isPaused;
  bool _isFinished;
  @override
  void initState() {
    _isPaused = false;
    _isFinished = false;
    _playAnimationController = SimpleAnimation('falling');
    //_idleController = SimpleAnimation('idle');
    _sandClocks = GetIt.I<TimerRepository>().sandClocks;
    timerStateOverTen = (widget.task.taskProgress * 10).round();
    setBoardAndRive();
    super.initState();
    context.read<TimerBloc>()
        .add(TimerStartEvent(widget.task.timeRemaining));
  }

  @override
  void dispose() {
    _artboard.removeController(_playAnimationController);
    _playAnimationController?.dispose();
    //_idleController?.dispose();
    super.dispose();
  }

  void setBoardAndRive() {
    _artboard?.removeController(_playAnimationController);
    _artboard = _sandClocks[timerStateOverTen].mainArtboard
      ..addController(_playAnimationController);
    _rive = Rive(
      artboard: _artboard,
    );
  }

  void _toggleAnimation(bool value) {
    setState(() {
      setBoardAndRive();
      _playAnimationController.isActive = value;
    });
  }

  void updateBoardImageWithNumber(int newNumber) {
    setState(() {
      timerStateOverTen = newNumber;
      setBoardAndRive();
    });
  }

  void onTimerFinished() {
    setState(() {
      _isFinished = true;
    });
  }

  void onTimerPausePressed() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> clockAndTime = [
      Container(
        height: 300,
        width: 300,
        child: _rive,
      ),
      TaskTimerText(widget.parentContext, widget.task, timerStateOverTen,
          updateBoardImageWithNumber: updateBoardImageWithNumber,
          onTimerFinished: onTimerFinished),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (size.height > size.width) SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: 350,
              child: size.width > size.height
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: clockAndTime,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: clockAndTime,
                    ),
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (!_isFinished)
            FlatButton(
              color: Colors.blue,
              shape: CircleBorder(),
              height: 70,
              child: _isPaused ? Icon(Icons.play_arrow) : Icon(Icons.pause),
              onPressed: () {
                _isPaused ? _toggleAnimation(true) : _toggleAnimation(false);
                BlocProvider.of<TimerBloc>(context)
                    .add((_isPaused) ? TimerResumeEvent() : TimerPauseEvent());
                onTimerPausePressed();
              },
            ),
          FlatButton(
              child: Icon(Icons.check),
              onPressed: () {
                _artboard.removeController(_playAnimationController);
                context.read<TimerBloc>().add(TimerFinishEvent());
              },
              color: Colors.green,
              height: 70,
              shape: CircleBorder()),
        ]),
        SizedBox(height: 5),
      ],
    );
  }
}
