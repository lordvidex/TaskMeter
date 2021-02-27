import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/messages_all.dart';
import '../models/app_theme.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  //! Strings

  //! Task Group Screen
  String get taskGroups => Intl.message('Task Groups',
      name: 'taskGroups', desc: 'The text Task Groups on the taskGroupScreen');

  String get progress => Intl.message('progress',
      name: 'progress',
      desc: 'text "progress" used to label'
          ' the linear progress indicator on this screen');

  String get emptyTaskGroupText => Intl.message('Task Group list is empty',
      name: 'emptyTaskGroupText',
      desc: 'Text displayed to user when taskgroup list is empty');

  String get clickOn => Intl.message('Click on ',
      name: 'clickOn',
      desc: 'Partial word displayed in the taskGroup screen telling the user'
          'how to add a new task Group');

  String get toAddNewTaskGroup => Intl.message('to add new Task Group',
      name: 'toAddNewTaskGroup',
      desc: 'Partial word displayed in the taskGroup screen'
          'telling the user how to add a new task Group');

  String get delete =>
      Intl.message('Delete', name: 'delete', desc: 'Text with the word delete');

  //! Settings Screen
  String get generalSettings => Intl.message('General Settings',
      name: 'generalSettings', desc: 'App bar text for setting screen');

  String get shortBreakDuration => Intl.message('Short Break Duration',
      name: 'shortBreakDuration', desc: 'label for short break duration');

  String get longBreakDuration => Intl.message(
        'Long Break Duration',
        name: 'longBreakDuration',
        desc: 'label for long break duration',
      );

  String get longBreakAfter => Intl.message(
        'Long Break after',
        name: 'longBreakAfter',
        desc: 'text for long break after or long break intervals',
      );

  String get language => Intl.message(
        'Language',
        name: 'language',
        desc: 'label for language',
      );

  String get appTheme => Intl.message(
        'App Theme',
        name: 'appTheme',
        desc: 'label for appTheme',
      );

  String get system => Intl.message(
        'System',
        name: 'system',
        desc: 'label text for system theme in settings',
      );

  String get theme => Intl.message('Theme',
      name: 'theme', desc: 'label text for the word "theme"');

  String get selectTheme => Intl.message(
        'Select Theme',
        name: 'selectTheme',
        desc: 'Appbar text for the selectThemeScreen',
      );

  String get dataNotSaved => Intl.message('Data not saved!',
      name: 'dataNotSaved',
      desc: 'title text displayed in CupertinoAlertDialog '
          'when user clicks back button without saving settings data');

  String get dataNotSavedDesc1 =>
      Intl.message('You have some unsaved data, go back and click ',
          name: 'dataNotSavedDesc1',
          desc: 'First part of description text shown in cupertinoAlertDialog '
              'when user clicks back button without saving settings data');

  String get dataNotSavedDesc2 => Intl.message(' at the top-right to save!',
      name: 'dataNotSavedDesc2',
      desc: 'Second part of description text shown in cupertinoAlertDialog when'
          ' user clicks back button without saving settings data');

  String get discard => Intl.message('Discard',
      name: 'discard',
      desc: 'cupertino action button text to discard data in settings screen');

  String get cancel => Intl.message('Cancel',
      name: 'cancel',
      desc: 'cupertino action button to go '
          'back and save changes in settings screen');

  String intervals(int x) => Intl.plural(x,
  one:'$x interval',
  few: '$x intervals',
  other:'$x intervals',
      name: 'intervals', desc: 'long break after x shortbreaks', args: [x]);

  String themeType(AppTheme theme) => Intl.select(
      theme,
      {
        AppTheme.Dark: 'Dark',
        AppTheme.Light: 'Light',
        AppTheme.System: 'System'
      },
      name: 'themeType',
      args: [theme],
      desc: 'returns the text based on themetypes [System,Dark,Light]');

  //! Task Group Description screen

  String taskCount(int x) => Intl.plural(x,
      zero: '$x tasks',
      one: '$x task',
      few: '$x tasks',
      other: '$x tasks',
      name: 'taskCount',
      desc: 'label text displaying number of tasks in the taskgroup',
      args: [x],
      examples: const {'x': 3});

  //! Create Task Group screen
  String get createTaskGroup => Intl.message('Create Task Group',
      name: 'createTaskGroup', desc: 'Header text in create task group screen');
  String get duration => Intl.message('Duration',
      name: 'duration', desc: 'hint text for duration picker widget');
  String get addTask => Intl.message('Add Task',
      name: 'addTask',
      desc: 'button Label text to add new task in a task group');
  String get create => Intl.message('Create',
      name: 'create',
      desc: 'buttonLabel for create button '
          '<for creating a new task group>');
  String get click => Intl.message('Click ',
      name: 'click',
      desc: 'first part of the empty textview displayed'
          ' when there is an empty list of tasks');
  String get shortBreak => Intl.message('Short Break',
      name: 'shortBreak', desc: 'label for short break');
  String get longBreak => Intl.message('Long Break',
      name: 'longBreak', desc: 'label for long break');
  String get toAddNewTask => Intl.message(' to add a new task',
      name: 'toAddNewTask',
      desc: 'second part of the displayed emptyview for tasklists');
  String get taskGroupName => Intl.message('Task Group Name',
      name: 'taskGroupName', desc: 'label text for task group name');
  String get taskGroupNameErrorText =>
      Intl.message('Enter a valid task group name',
          name: 'taskGroupNameErrorText',
          desc: 'error text shown when task group name is empty');

//! Duration Utils
//TODO: fix padezh 2 for <few>
  String hours(int hours) => Intl.plural(
        hours,
        zero: '',
        one: '$hours Hour ',
        few: '$hours Hours ',
        other: '$hours Hours ',
        args: [hours],
        examples: const {'1': '1 Hour', '2': '2 Hours'},
        desc: 'string for displaying how many hours are in the duration object',
        name: 'hours',
      );
  String minutes(int minutes) => Intl.plural(
        minutes,
        zero: '$minutes minutes ',
        one: '$minutes Minute ',
        few: '$minutes Minutes ',
        other: '$minutes Minutes ',
        args: [minutes],
        examples: const {'1': '1 Minute ', '2': '2 Minutes '},
        desc:
            'string for displaying how many minutes are in the duration object',
        name: 'minutes',
      );
  String seconds(int seconds) => Intl.plural(
        seconds,
        zero: '',
        one: '$seconds Second',
        few: '$seconds Seconds',
        other: '$seconds Seconds',
        args: [seconds],
        examples: const {'1': '1 Second', '2': '2 Seconds'},
        desc:
            'string for displaying how many seconds are in the duration object',
        name: 'seconds',
      );
  String get taskName => Intl.message('Task Name',
      name: 'taskName',
      desc: 'AlertDialog textField title for inputting taskName');
  String get difficulty => Intl.message(
        'Difficulty',
        name: 'difficulty',
        desc:
            'difficulty header for picking difficulty when creating/editing task',
      );
  String get typeTaskName => Intl.message(
        'Type task name...',
        name: 'typeTaskName',
        desc: 'label text for inputting task name',
      );

  String get add =>
      Intl.message('Add', name: 'add', desc: 'button text label to add task');
  String get edit => Intl.message('Edit',
      name: 'edit', desc: 'label text for finishing task edit');
  String get enterTaskName => Intl.message('Enter task name',
      name: 'enterTaskName', desc: 'error text if task name has errors');

      //! Duration Picker
      String get min => Intl.message('min.',
      name: 'min',
      desc: 'Short text for min in duration picker');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
