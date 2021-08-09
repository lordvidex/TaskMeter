import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:task_meter/presentation/providers/settings_provider.dart';

import '../../../core/constants.dart';
import '../../../domain/models/task.dart';
import '../../../domain/models/task_group.dart';
import '../../../locale/locales.dart';
import '../task_timer/action_button.dart';
import 'custom_text_form_field.dart';

class AddTaskWidget extends StatefulWidget {
  final Function(Task, {bool isEditMode}) addNewTask;
  final TaskGroup taskGroup;
  final Task taskToBeEdited;
  final bool isEditMode;
  final OnboardingState onboarding;
  final List<FocusNode> focusNodes;
  final Function(BuildContext) createTaskGroup;
  AddTaskWidget({
    @required this.taskGroup,
    @required this.addNewTask,
    @required this.isEditMode,
    @required this.focusNodes,
    @required this.onboarding,
    @required this.createTaskGroup,
    @required this.taskToBeEdited,
  });
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  Difficulty _difficulty;
  bool _isEditMode;

  TextEditingController _taskNameController;
  GlobalKey<FormState> _formKey;

  @override
  void dispose() {
    _taskNameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _isEditMode = widget.isEditMode;
    _formKey = GlobalKey();
    _taskNameController = TextEditingController(
        text: _isEditMode ? widget.taskToBeEdited.taskName : null);

    _difficulty =
        _isEditMode ? widget.taskToBeEdited.difficulty : Difficulty.Medium;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!context.read<SettingsProvider>().hasPassedTutorial)
        Future.delayed(Duration(milliseconds: 500),
            () => widget.onboarding.showWithSteps(3, [3, 4, 5]));
    });
    super.initState();
  }

  void addTask() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (_isEditMode) {
      Task task = widget.taskToBeEdited;
      task
        ..difficulty = _difficulty
        ..taskName = _taskNameController.text.trim();
      //! we need to call this to reset the state
      widget.addNewTask(null, isEditMode: true);
    } else {
      widget.addNewTask(Task(
          taskName: _taskNameController.text.trim(), difficulty: _difficulty));
    }
    resetInputElements();
    final hasPassedTutorial =
        context.read<SettingsProvider>().hasPassedTutorial;
    Future.delayed(Duration(milliseconds: 500), () {
      if (!hasPassedTutorial) widget.onboarding.showFromIndex(6);
    });
    Navigator.of(context).pop();
  }

  void resetInputElements() {
    _taskNameController.clear();
    FocusScope.of(context).unfocus();
    _difficulty = Difficulty.Medium;
    setState(() {
      _isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocale = AppLocalizations.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${appLocale.add} ${appLocale.subTask}',
                          style: TextStyle(fontSize: 24),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            size: 30,
                            color: isDarkMode
                                ? Colors.white
                                : Constants.appLightBlue,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  ),
                  Focus(
                    focusNode: widget.focusNodes[3],
                    child: CustomTextFormField(
                      isDarkMode: isDarkMode,
                      controller: _taskNameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return appLocale.emptyErrorMessage;
                        }
                        return null;
                      },
                      labelText: appLocale.enterTaskName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      appLocale.difficulty,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Focus(
                    focusNode: widget.focusNodes[4],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ActionButton(
                          borderColor: Constants.appGreen,
                          onPressed: () =>
                              setState(() => _difficulty = Difficulty.Easy),
                          filled: _difficulty == Difficulty.Easy,
                          fillColor: Constants.appLightGreen,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          text: 'Easy',
                          textColor: Constants.appGreen,
                        ),
                        ActionButton(
                            borderColor: Constants.appBlue,
                            onPressed: () =>
                                setState(() => _difficulty = Difficulty.Medium),
                            filled: _difficulty == Difficulty.Medium,
                            fillColor: Constants.appLightBlue,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            textColor: Constants.appBlue,
                            text: 'Medium'),
                        ActionButton(
                            onPressed: () =>
                                setState(() => _difficulty = Difficulty.Hard),
                            filled: _difficulty == Difficulty.Hard,
                            fillColor: Constants.appLightRed,
                            borderColor: Constants.appRed,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            textColor: Constants.appRed,
                            text: 'Hard')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Focus(
                            focusNode: widget.focusNodes[5],
                            child: ActionButton(
                              resizable: true,
                              onPressed: () => addTask(),
                              fillColor: Constants.appBlue,
                              text:
                                  _isEditMode ? appLocale.edit : appLocale.add,
                              icon: Icon(Icons.add,
                                  color: Colors.white, size: 24),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 36,
                        ),
                        Expanded(
                          child: ActionButton(
                              resizable: true,
                              onPressed: () {
                                widget.createTaskGroup(context);
                                Navigator.of(context).pop();
                              },
                              fillColor: Constants.appGreen,
                              text: appLocale.complete),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
