import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/messages_all.dart';
import '../domain/models/app_theme.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  //! Strings

  //! Task Group Screen
  String get taskCompleted =>
      Intl.message('Task completed', name: 'taskCompleted', desc: '');
  String get trackedHours =>
      Intl.message('Tracked Hours', name: 'trackedHours', desc: '');
  String get activeTasks =>
      Intl.message('Active Tasks', name: 'activeTasks', desc: '');
  String taskRatioDesc(int done, int total) => Intl.plural(
        total,
        name: 'taskRatioDesc',
        desc: 'caption text for taskgroup tiles',
        one: '$done of $total task completed',
        few: '$done of $total tasks completed',
        other: '$done of $total tasks completed',
        args: [done, total],
      );
  String get progress => Intl.message(
        'progress',
        name: 'progress',
        desc: 'text "progress" used to label'
            ' the linear progress indicator on this screen',
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        desc: 'Text with the word delete',
      );
  String get emptyHere => Intl.message('It\'s empty here,',
      name: 'emptyHere',
      desc: 'Place holder text when there is no active task group');

  String get createTaskToContinue => Intl.message('Create task to continue',
      name: 'createTaskToContinue',
      desc:
          'second part of place holder text when there is no active task group');

  //! Settings Screen
  String get and => Intl.message('and', name: 'and', desc: 'the word "and"');
  String get tasks => Intl.message('Tasks', name: 'tasks', desc: '');
  String get languageAndAppearance => Intl.message('Language and Appearance',
      name: 'languageAndAppearance', desc: '');
  String get settings =>
      Intl.message('Settings', name: 'settings', desc: 'The word settings');
  String get generalSettings => Intl.message('General Settings',
      name: 'generalSettings', desc: 'App bar text for setting screen');

  String get shortBreakDuration => Intl.message('Short break duration',
      name: 'shortBreakDuration', desc: 'label for short break duration');

  String get longBreakDuration => Intl.message(
        'Long break duration',
        name: 'longBreakDuration',
        desc: 'label for long break duration',
      );

  String get longBreakAfter => Intl.message(
        'Long break after',
        name: 'longBreakAfter',
        desc: 'text for long break after or long break intervals',
      );
  String get longBreakIntervals => Intl.message('Long break intervals',
      name: 'longBreakIntervals', desc: '');
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

  String get cancel => Intl.message('Cancel', name: 'cancel', desc: '');

  String intervals(int x) => Intl.plural(x,
      one: '$x interval',
      few: '$x intervals',
      other: '$x intervals',
      name: 'intervals',
      desc: 'long break after x shortbreaks',
      args: [x]);

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
  String get about => Intl.message('About',
      name: 'about',
      desc: 'label for the text about, leading to the about page of the app');
  String get rate => Intl.message('Rate in the app store',
      name: 'rate', desc: 'rate in the app store');

  String get feedback =>
      Intl.message('Feedback', name: 'feedback', desc: 'Feedback');

  //! Task Group Description screen
  String get editTask => Intl.message('Edit task',
      name: 'editTask',
      desc: 'Button text to edit newly created task in description screen');
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
  String get createTask => Intl.message('Create Task',
      name: 'createTask', desc: 'Header text in create task group screen');
  String get shortBreak => Intl.message('Short break',
      name: 'shortBreak', desc: 'label for short break');
  String get longBreak => Intl.message('Long break',
      name: 'longBreak', desc: 'label for long break');
  String get durationInMinutes => Intl.message('Duration (in minutes)',
      name: 'durationInMinutes',
      desc: 'Label for total duration picker in create task group screen');
  String get subTask => Intl.message('Sub-Task',
      name: 'subTask', desc: 'label text for subtasks');
  String get emptyErrorMessage => Intl.message('Please enter some text',
      desc: 'error text shown when user leaves textfield empty',
      name: 'emptyErrorMessage');
  String get taskGroupNameErrorText =>
      Intl.message('Enter a valid task group name',
          name: 'taskGroupNameErrorText',
          desc: 'error text shown when task group name is empty');
  String get addSubTask => Intl.message('Add Sub Task',
      name: 'addSubTask', desc: 'Button label text for adding sub task');
  String get taskTitle => Intl.message('Task Title',
  name: 'taskTitle',
  desc: '');
  String get enterTitle => Intl.message('Enter the title of the task',
  name: 'enterTitle',
  desc: 'desc for first onboarding');
  String get duration => Intl.message('Duration',
  name: 'duration',
  desc: '');
  String get durationDesc => Intl.message('Indicate the duration of this task in minutes.',
  name: 'durationDesc',
  desc: '');
  String get subTaskDesc => Intl.message('You can add subtasks to this tasks. The duration of each subtask is automatically calculated.',
  name: 'subTaskDesc',
  desc: 'Onboarding description');
  String get subTaskTitle => Intl.message('SubTask Title',
  name: 'subTaskTitle',
  desc: '');
  String get subTaskTitleDesc => Intl.message('Enter the title of the subtask',
  name: 'subTaskTitleDesc',
  desc: '');
  String get difficultyDesc => Intl.message('Indicate the difficulty of this subtask to assist in time division among subtasks.\n(Medium is default)',
  name: 'difficultyDesc',
  desc: 'Onboarding desc for difficulty');
  
//! Task Timer Screen
  String get complete =>
      Intl.message('Complete', name: 'complete', desc: 'The word complete');
  String get breakComplete =>
      Intl.message('Break Complete', name: 'breakComplete', desc: '');
  String get taskComplete =>
      Intl.message('Task Complete', name: 'taskComplete', desc: '');
  String get resume => Intl.message('Resume', name: 'resume', desc: '');
  String get pause => Intl.message('Pause', name: 'pause', desc: '');
  String get takeBreak => Intl.message('Take Break',
      name: 'takeBreak',
      desc:
          'Button option for when user should take break when a task just finished');
  String get nextTask => Intl.message('Next Task',
      name: 'nextTask',
      desc:
          'Button option for when user should jump to next task when a task just finished');
//! Authentication Screen
  String get signup =>
      Intl.message('Sign up', name: 'signup', desc: 'The text sign up');
  String get signIn =>
      Intl.message('Sign in', name: 'signIn', desc: 'the text sign in');
  String get withLabel =>
      Intl.message('with', name: 'withLabel', desc: 'the word with');
  String get enterEmail => Intl.message('Enter email address',
      name: 'enterEmail',
      desc:
          'Hint text for authentication screen telling user to enter email address');
  String get enterPassword => Intl.message('Password',
      name: 'enterPassword', desc: 'Password textField hint text');
  String get next => Intl.message('Next',
      name: 'next',
      desc:
          'Button text for the next button toggling between email and password mode in auth screen');

  String get enterRecoveryMail => Intl.message('Enter recovery email address',
      name: 'enterRecoveryMail', desc: 'label for recovery email address');
  String get forgotPassword =>
      Intl.message('Forgot Password?', name: 'forgotPassword', desc: '');
  String get sendRecoveryMail =>
      Intl.message('Send Recovery Mail', name: 'sendRecoveryMail', desc: '');
  String get continueLabel => Intl.message('Continue',
      name: 'continueLabel', desc: 'The word "continue"');
  String get checkInbox => Intl.message(
      'Check your inbox to set new password for this email',
      name: 'checkInbox',
      desc: 'instruction text guiding user when trying to recover password');
  String get getStarted => Intl.message('Let\'s get started',
      name: 'getStarted', desc: 'Intro text');
  String continueWith(String socialPlatform) => Intl.message(
        'Continue with $socialPlatform',
        args: [socialPlatform],
        name: 'continueWith',
      );
  String get continueAsGuest =>
      Intl.message('Continue as Guest', name: 'continueAsGuest', desc: '');
  String get termsAndServices => Intl.message(
      'By continuing, you confirm your agreement to our Terms of Service and privacy policy',
      name: 'termsAndServices',
      desc: '');
  String get errorOccured => Intl.message('An error occured!',
      name: 'errorOccured', desc: 'error dialog label');
  String get newAccount =>
      Intl.message('New Account', name: 'newAccount', desc: '');
  String get newAccountAgreement => Intl.message(
      'By Clicking continue, you agree to create a new account with the following credentials.',
      name: 'newAccountAgreement',
      desc: '');

//! Duration Utils
  String hours(int hours) => Intl.plural(
        hours,
        zero: '',
        one: '$hours Hour',
        few: '$hours Hours',
        other: '$hours Hours',
        args: [hours],
        examples: const {'1': '1 Hour', '2': '2 Hours'},
        desc: 'string for displaying how many hours are in the duration object',
        name: 'hours',
      );
  String minutes(int minutes) => Intl.plural(
        minutes,
        zero: '',
        one: '$minutes minute',
        few: '$minutes minutes',
        other: '$minutes minutes',
        args: [minutes],
        examples: const {'1': '1 minute', '2': '2 minutes'},
        desc:
            'string for displaying how many minutes are in the duration object',
        name: 'minutes',
      );
  String seconds(int seconds) => Intl.plural(
        seconds,
        zero: '',
        one: '$seconds second',
        few: '$seconds seconds',
        other: '$seconds seconds',
        args: [seconds],
        examples: const {'1': '1 second', '2': '2 seconds'},
        desc:
            'string for displaying how many seconds are in the duration object',
        name: 'seconds',
      );
  String get taskName => Intl.message('Task name',
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
      name: 'min', desc: 'Short text for min in duration picker');
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
