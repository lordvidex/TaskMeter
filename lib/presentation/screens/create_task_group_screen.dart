import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/presentation/widgets/app_back_button.dart';

import '../../core/algorithms/time_divider.dart';
import '../../core/constants.dart';
import '../../core/errors.dart';
import '../../core/utils/duration_utils.dart';
import '../../domain/models/settings.dart';
import '../../domain/models/task.dart';
import '../../domain/models/task_group.dart';
import '../../locale/locales.dart';
import '../providers/settings_provider.dart';
import '../providers/task_group_provider.dart';
import '../widgets/create_task_group/add_task_widget.dart';
import '../widgets/create_task_group/custom_text_form_field.dart';
import '../widgets/task_group_description/task_card.dart';
import '../widgets/task_timer/action_button.dart';

class CreateTaskGroupScreen extends StatefulWidget {
  static const routeName = '/new-task-group';
  @override
  _CreateTaskGroupScreenState createState() => _CreateTaskGroupScreenState();
}

class _CreateTaskGroupScreenState extends State<CreateTaskGroupScreen> {
  GlobalKey<FormState> _formKey;
  TaskGroup newTaskGroup;
  Settings settings;

  int _durationInMinutes;
  int _shortBreakInMinutes;
  int _longBreakInMinutes;

  // TextEditingController for the TaskGroupTitle
  TextEditingController _tgTitleController;
  // TextEditingController for the duration
  TextEditingController _durationController;
  FocusNode _durationFocusNode;
  // TextEditingController for the shortbreak
  TextEditingController _shortBreakController;
  FocusNode _shortBreakFocusNode;
  // TextEditingController for the longBreak
  TextEditingController _longBreakController;
  FocusNode _longBreakFocusNode;
  // Scroll controller for the screen
  ScrollController _scrollController;
  // ScrollController for the list of tasks in the taskgroup
  ScrollController _taskScrollController;

  // true when user is adding new task
  bool modalIsActive;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _scrollController = ScrollController();
    _taskScrollController = ScrollController();
    _shortBreakFocusNode = FocusNode();
    _longBreakFocusNode = FocusNode();
    _durationFocusNode = FocusNode();
    modalIsActive = false;

    settings = context.read<SettingsProvider>().settings;
    _durationInMinutes = settings.totalTime.inMinutes;
    _shortBreakInMinutes = settings.shortBreak.inMinutes;
    _longBreakInMinutes = settings.longBreak.inMinutes;

    newTaskGroup = TaskGroup('',
        longBreakIntervals: settings.longBreakIntervals,
        shortBreakTime: settings.shortBreak,
        longBreakTime: settings.longBreak,
        totalTime: settings.totalTime);

    _tgTitleController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    final appLocale = AppLocalizations.of(context);
    _durationController ??= TextEditingController(
        text: DurationUtils.durationToReadableString(
            Duration(minutes: _durationInMinutes), appLocale));
    _shortBreakController ??= TextEditingController(
        text: DurationUtils.durationToReadableString(
            Duration(minutes: _shortBreakInMinutes), appLocale));
    _longBreakController ??= TextEditingController(
        text: DurationUtils.durationToReadableString(
            Duration(minutes: _longBreakInMinutes), appLocale));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _taskScrollController.dispose();

    _tgTitleController.dispose();
    _durationController.dispose();
    _durationFocusNode.dispose();
    _shortBreakController.dispose();
    _shortBreakFocusNode.dispose();
    _longBreakController.dispose();
    _longBreakFocusNode.dispose();
  }

  void createTaskGroup(BuildContext scaffoldContext) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    newTaskGroup.taskGroupName = _tgTitleController.text;
    newTaskGroup.shortBreakTime = Duration(minutes: _shortBreakInMinutes);
    newTaskGroup.longBreakTime = Duration(minutes: _longBreakInMinutes);
    // TODO: add widget for this
    newTaskGroup.longBreakIntervals = settings.longBreakIntervals;

    try {
      TimeDivider.divideTimeByTask(newTaskGroup);
    } on TaskTimerException catch (e) {
      // error occured and should be shown to user in snackbar
      ScaffoldMessenger.of(scaffoldContext).removeCurrentSnackBar();
      ScaffoldMessenger.of(scaffoldContext)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }
    context.read<TaskGroupProvider>().addTaskGroup(newTaskGroup);
    // go to the main page
    Navigator.of(context).pop();
  }

  void addNewTask(Task newTask, {bool isEditMode = false}) {
    setState(() {
      if (!isEditMode) newTaskGroup.tasks.add(newTask);
    });
    Timer(Duration(milliseconds: 100), () {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
      _taskScrollController
          .jumpTo(_taskScrollController.position.maxScrollExtent);
    });
  }

  void deleteTask(Task task) {
    setState(() {
      newTaskGroup.tasks.removeWhere((t) => t.taskId == task.taskId);
    });
  }

  void showAddNewTaskBottomSheet(BuildContext sheetContext, bool isDarkMode,
      {bool isEditMode = false, Task taskToBeEdited}) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: isDarkMode ? Color(0xff111424) : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: sheetContext,
        builder: (ctx2) => AddTaskWidget(
              createTaskGroup: createTaskGroup,
              addNewTask: addNewTask,
              isEditMode: isEditMode,
              taskGroup: newTaskGroup,
              taskToBeEdited: taskToBeEdited,
            )).then((_) {
      setState(() => modalIsActive = false);
    });
  }

  /// Scroll container for the sub tasks added within the task group
  List<Widget> subTaskViews(ScrollController _taskScrollController) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 20),
        child: Text(
          'Sub-Task',
          style: TextStyle(fontSize: 18),
        ),
      ),
      Container(
        height: modalIsActive ? 125 : 250,
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _taskScrollController,
          child: ReorderableListView(
              scrollController: _taskScrollController,
              children: newTaskGroup.tasks
                  .map((t) => Builder(
                        key: ValueKey(t.taskId),
                        builder: (ctx) => TaskCard(
                            taskGroup: newTaskGroup,
                            deleteTask: deleteTask,
                            isEditMode: true,
                            editTask: showAddNewTaskBottomSheet,
                            task: t),
                      ))
                  .toList(),
              onReorder: (oldIndex, newIndex) {
                if (newIndex < 0) {
                  newIndex = 0;
                }
                if (newIndex >= newTaskGroup.tasks.length) {
                  newIndex = newTaskGroup.tasks.length - 1;
                }
                Task temp = newTaskGroup.tasks[oldIndex];
                newTaskGroup.tasks[oldIndex] = newTaskGroup.tasks[newIndex];
                newTaskGroup.tasks[newIndex] = temp;
                setState(() {});
              }),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // action buttons at the bottom of the create task group screen for
    // adding subtasks and creating the taskgroup
    final _actionButtons = [
      Padding(
        padding: const EdgeInsets.only(top: 80, bottom: 10),
        child: Align(
          alignment: Alignment.center,
          child: Builder(
            builder: (ctx) => Container(
              width: 229,
              child: ActionButton(
                resizable: true,
                onPressed: () {
                  setState(() {
                    modalIsActive = true;
                  });
                  Timer(
                      Duration(milliseconds: 100),
                      () => _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent,
                          ));
                  showAddNewTaskBottomSheet(ctx, isDarkMode);
                },
                fillColor: Constants.appBlue,
                text: 'Add Sub Task',
                // padding: EdgeInsets.symmetric(
                //     horizontal: , vertical: 14),
              ),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Builder(
          builder: (ctx) => Container(
            width: 229,
            child: ActionButton(
              resizable: true,
              onPressed: () => createTaskGroup(context),
              fillColor: Constants.appGreen,
              text: appLocale.createTask,
            ),
          ),
        ),
      )
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    'assets/icons/back.svg',
                    width: 29,
                    height: 24,
                    color: isDarkMode ? Colors.white : null,
                  )),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  appLocale.createTask,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                            labelText: appLocale.enterTaskName,
                            isDarkMode: isDarkMode,
                            controller: _tgTitleController,
                            onSubmitted: (_) {
                              _durationController.clear();
                              _durationFocusNode.requestFocus();
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return appLocale.taskGroupNameErrorText;
                              }
                              return null;
                            }),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 12),
                            child: Text(appLocale.durationInMinutes,
                                style: TextStyle(fontSize: 18))),
                        CustomTextFormField.numbersOnly(
                          context: context,
                          focusNode: _durationFocusNode,
                          onChanged: (x) => _durationInMinutes =
                              int.tryParse(x.trim()) ?? _durationInMinutes,
                          onSubmitted: (_) {
                            _durationController.text =
                                DurationUtils.durationToReadableString(
                                    Duration(minutes: _durationInMinutes),
                                    appLocale);
                            _shortBreakController.clear();
                            _shortBreakFocusNode.requestFocus();
                          },
                          controller: _durationController,
                          hintText: appLocale.minutes(30),
                          isDarkMode: isDarkMode,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 125),
                                      child: Text(appLocale.shortBreak,
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 125,
                                        child: CustomTextFormField.numbersOnly(
                                          focusNode: _shortBreakFocusNode,
                                          onChanged: (x) =>
                                              _shortBreakInMinutes =
                                                  int.tryParse(x.trim()) ??
                                                      _shortBreakInMinutes,
                                          onSubmitted: (_) {
                                            _shortBreakController.text =
                                                DurationUtils
                                                    .durationToReadableString(
                                                        Duration(
                                                            minutes:
                                                                _shortBreakInMinutes),
                                                        appLocale);
                                            _longBreakController.clear();
                                            _longBreakFocusNode.requestFocus();
                                          },
                                          context: context,
                                          controller: _shortBreakController,
                                          hintText: appLocale.minutes(5),
                                          isDarkMode: isDarkMode,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 125),
                                      child: Text(appLocale.longBreak,
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 125,
                                        child: CustomTextFormField.numbersOnly(
                                          focusNode: _longBreakFocusNode,
                                          context: context,
                                          onChanged: (x) =>
                                              _longBreakInMinutes =
                                                  int.tryParse(x.trim()) ??
                                                      _longBreakInMinutes,
                                          onSubmitted: (_) {
                                            _longBreakController.text =
                                                DurationUtils
                                                    .durationToReadableString(
                                                        Duration(
                                                            minutes:
                                                                _longBreakInMinutes),
                                                        appLocale);
                                          },
                                          hintText: appLocale.minutes(10),
                                          controller: _longBreakController,
                                          isDarkMode: isDarkMode,
                                        )),
                                  ],
                                )
                              ],
                            )),
                        if (newTaskGroup.tasks.isNotEmpty)
                          ...subTaskViews(_taskScrollController),
                        if (modalIsActive)
                          SizedBox(
                            height: 80,
                          ),
                        if (!modalIsActive) ..._actionButtons
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
