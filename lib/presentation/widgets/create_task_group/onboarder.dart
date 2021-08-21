import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import '../../providers/settings_provider.dart';

class Onboarder extends StatefulWidget {
  static final routeName = '/onboarder';
  final Widget child;

  const Onboarder({required this.child});

  @override
  _OnboarderState createState() => _OnboarderState();
}

class _OnboarderState extends State<Onboarder> {
  late GlobalKey<OnboardingState> _onboardingKey;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    _onboardingKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _focusNodes = context.read<SettingsProvider>().onboardingFocusNodes;
    final _titleTextStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 36);
    List<OnboardingStep> _steps = [
      OnboardingStep(
        focusNode: _focusNodes[0],
        title: 'Task Title',
        titleTextStyle: _titleTextStyle,
        delay: Duration(seconds: 5),
        bodyText: 'Enter the title of the task',
      ),
      OnboardingStep(
        focusNode: _focusNodes[1],
        title: 'Duration',
        titleTextStyle: _titleTextStyle,
        bodyText: 'Indicate the duration of this task in minutes.',
      ),
      OnboardingStep(
        focusNode: _focusNodes[2],
        title: 'SubTasks',
        titleTextStyle: _titleTextStyle,
        bodyText:
            'You can add subtasks to this tasks. The duration of each subtask is automatically calculated.',
      ),
      OnboardingStep(
        focusNode: _focusNodes[3],
        title: 'SubTask Title',
        titleTextStyle: _titleTextStyle,
        bodyText: 'Enter the title of the subtask',
      ),
      OnboardingStep(
        focusNode: _focusNodes[4],
        title: 'Difficulty',
        titleTextStyle: _titleTextStyle,
        bodyText:
            'Indicate the difficulty of this subtask to assist in time division among subtasks.\n(Medium is default)',
      ),
      OnboardingStep(
          focusNode: _focusNodes[5],
          title: 'Add the subtask',
          titleTextStyle: _titleTextStyle),
      OnboardingStep(
          focusNode: _focusNodes[6],
          title: 'Create the Task',
          titleTextStyle: _titleTextStyle)
    ];
    return Onboarding(
      child: widget.child,
      steps: _steps,
      initialIndex: 0,
      onChanged: (index) {
        if (index == 5) {
          context.read<SettingsProvider>().hasPassedTutorial = true;
        }
      },
      key: _onboardingKey,
    );
  }
}
