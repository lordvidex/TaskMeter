import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import '../../../locale/locales.dart';

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
    final appLocale = AppLocalizations.of(context);
    final _titleTextStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 36, color: Colors.blue);
    List<OnboardingStep> _steps = [
      OnboardingStep(
        focusNode: _focusNodes[0],
        title: appLocale.taskTitle,
        titleTextStyle: _titleTextStyle,
        delay: Duration(seconds: 5),
        bodyText: appLocale.enterTitle,
      ),
      OnboardingStep(
        focusNode: _focusNodes[1],
        title: appLocale.duration,
        titleTextStyle: _titleTextStyle,
        bodyText: appLocale.durationDesc,
      ),
      OnboardingStep(
        focusNode: _focusNodes[2],
        title: appLocale.subTask,
        titleTextStyle: _titleTextStyle,
        bodyText: appLocale.subTaskDesc,
      ),
      OnboardingStep(
        focusNode: _focusNodes[3],
        title: appLocale.subTaskTitle,
        titleTextStyle: _titleTextStyle,
        bodyText: appLocale.subTaskTitleDesc,
      ),
      OnboardingStep(
        focusNode: _focusNodes[4],
        title: appLocale.difficulty,
        titleTextStyle: _titleTextStyle,
        bodyText: appLocale.difficultyDesc,
      ),
      OnboardingStep(
          focusNode: _focusNodes[5],
          title: appLocale.addSubTask,
          titleTextStyle: _titleTextStyle),
      OnboardingStep(
          focusNode: _focusNodes[6],
          title: appLocale.createTask,
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
