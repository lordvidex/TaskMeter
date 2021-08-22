// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(socialPlatform) => "Continue with ${socialPlatform}";

  static m1(hours) => "${Intl.plural(hours, zero: '', one: '${hours} Hour', few: '${hours} Hours', other: '${hours} Hours')}";

  static m2(x) => "${Intl.plural(x, one: '${x} interval', few: '${x} intervals', other: '${x} intervals')}";

  static m3(minutes) => "${Intl.plural(minutes, zero: '', one: '${minutes} minute', few: '${minutes} minutes', other: '${minutes} minutes')}";

  static m4(seconds) => "${Intl.plural(seconds, zero: '', one: '${seconds} second', few: '${seconds} seconds', other: '${seconds} seconds')}";

  static m5(x) => "${Intl.plural(x, zero: '${x} tasks', one: '${x} task', few: '${x} tasks', other: '${x} tasks')}";

  static m6(done, total) => "${Intl.plural(total, one: '${done} of ${total} task completed', few: '${done} of ${total} tasks completed', other: '${done} of ${total} tasks completed')}";

  static m7(theme) => "${Intl.select(theme, {'Dark': 'Dark', 'Light': 'Light', 'System': 'System', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "activeTasks" : MessageLookupByLibrary.simpleMessage("Active Tasks"),
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addSubTask" : MessageLookupByLibrary.simpleMessage("Add Sub Task"),
    "and" : MessageLookupByLibrary.simpleMessage("and"),
    "appTheme" : MessageLookupByLibrary.simpleMessage("App Theme"),
    "breakComplete" : MessageLookupByLibrary.simpleMessage("Break Complete"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "checkInbox" : MessageLookupByLibrary.simpleMessage("Check your inbox to set new password for this email"),
    "complete" : MessageLookupByLibrary.simpleMessage("Complete"),
    "continueAsGuest" : MessageLookupByLibrary.simpleMessage("Continue as Guest"),
    "continueLabel" : MessageLookupByLibrary.simpleMessage("Continue"),
    "continueWith" : m0,
    "createTask" : MessageLookupByLibrary.simpleMessage("Create Task"),
    "createTaskToContinue" : MessageLookupByLibrary.simpleMessage("Create task to continue"),
    "dataNotSaved" : MessageLookupByLibrary.simpleMessage("Data not saved!"),
    "dataNotSavedDesc1" : MessageLookupByLibrary.simpleMessage("You have some unsaved data, go back and click "),
    "dataNotSavedDesc2" : MessageLookupByLibrary.simpleMessage(" at the top-right to save!"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "difficulty" : MessageLookupByLibrary.simpleMessage("Difficulty"),
    "difficultyDesc" : MessageLookupByLibrary.simpleMessage("Indicate the difficulty of this subtask to assist in time division among subtasks.\n(Medium is default)"),
    "discard" : MessageLookupByLibrary.simpleMessage("Discard"),
    "duration" : MessageLookupByLibrary.simpleMessage("Duration"),
    "durationDesc" : MessageLookupByLibrary.simpleMessage("Indicate the duration of this task in minutes."),
    "durationInMinutes" : MessageLookupByLibrary.simpleMessage("Duration (in minutes)"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Edit task"),
    "emptyErrorMessage" : MessageLookupByLibrary.simpleMessage("Please enter some text"),
    "emptyHere" : MessageLookupByLibrary.simpleMessage("It\'s empty here,"),
    "enterEmail" : MessageLookupByLibrary.simpleMessage("Enter email address"),
    "enterPassword" : MessageLookupByLibrary.simpleMessage("Password"),
    "enterRecoveryMail" : MessageLookupByLibrary.simpleMessage("Enter recovery email address"),
    "enterTaskName" : MessageLookupByLibrary.simpleMessage("Enter task name"),
    "enterTitle" : MessageLookupByLibrary.simpleMessage("Enter the title of the task"),
    "errorOccured" : MessageLookupByLibrary.simpleMessage("An error occured!"),
    "feedback" : MessageLookupByLibrary.simpleMessage("Feedback"),
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "generalSettings" : MessageLookupByLibrary.simpleMessage("General Settings"),
    "getStarted" : MessageLookupByLibrary.simpleMessage("Let\'s get started"),
    "hours" : m1,
    "intervals" : m2,
    "language" : MessageLookupByLibrary.simpleMessage("Language"),
    "languageAndAppearance" : MessageLookupByLibrary.simpleMessage("Language and Appearance"),
    "longBreak" : MessageLookupByLibrary.simpleMessage("Long break"),
    "longBreakAfter" : MessageLookupByLibrary.simpleMessage("Long break after"),
    "longBreakDuration" : MessageLookupByLibrary.simpleMessage("Long break duration"),
    "longBreakIntervals" : MessageLookupByLibrary.simpleMessage("Long break intervals"),
    "min" : MessageLookupByLibrary.simpleMessage("min."),
    "minutes" : m3,
    "newAccount" : MessageLookupByLibrary.simpleMessage("New Account"),
    "newAccountAgreement" : MessageLookupByLibrary.simpleMessage("By Clicking continue, you agree to create a new account with the following credentials."),
    "next" : MessageLookupByLibrary.simpleMessage("Next"),
    "nextTask" : MessageLookupByLibrary.simpleMessage("Next Task"),
    "pause" : MessageLookupByLibrary.simpleMessage("Pause"),
    "progress" : MessageLookupByLibrary.simpleMessage("progress"),
    "rate" : MessageLookupByLibrary.simpleMessage("Rate in the app store"),
    "resume" : MessageLookupByLibrary.simpleMessage("Resume"),
    "seconds" : m4,
    "selectTheme" : MessageLookupByLibrary.simpleMessage("Select Theme"),
    "sendRecoveryMail" : MessageLookupByLibrary.simpleMessage("Send Recovery Mail"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shortBreak" : MessageLookupByLibrary.simpleMessage("Short break"),
    "shortBreakDuration" : MessageLookupByLibrary.simpleMessage("Short break duration"),
    "signIn" : MessageLookupByLibrary.simpleMessage("Sign in"),
    "signup" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "subTask" : MessageLookupByLibrary.simpleMessage("Sub-Task"),
    "subTaskDesc" : MessageLookupByLibrary.simpleMessage("You can add subtasks to this tasks. The duration of each subtask is automatically calculated."),
    "subTaskTitle" : MessageLookupByLibrary.simpleMessage("SubTask Title"),
    "subTaskTitleDesc" : MessageLookupByLibrary.simpleMessage("Enter the title of the subtask"),
    "system" : MessageLookupByLibrary.simpleMessage("System"),
    "takeBreak" : MessageLookupByLibrary.simpleMessage("Take Break"),
    "taskComplete" : MessageLookupByLibrary.simpleMessage("Task Complete"),
    "taskCompleted" : MessageLookupByLibrary.simpleMessage("Task completed"),
    "taskCount" : m5,
    "taskGroupNameErrorText" : MessageLookupByLibrary.simpleMessage("Enter a valid task group name"),
    "taskName" : MessageLookupByLibrary.simpleMessage("Task name"),
    "taskRatioDesc" : m6,
    "taskTitle" : MessageLookupByLibrary.simpleMessage("Task Title"),
    "tasks" : MessageLookupByLibrary.simpleMessage("Tasks"),
    "termsAndServices" : MessageLookupByLibrary.simpleMessage("By continuing, you confirm your agreement to our Terms of Service and privacy policy"),
    "theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "themeType" : m7,
    "trackedHours" : MessageLookupByLibrary.simpleMessage("Tracked Hours"),
    "typeTaskName" : MessageLookupByLibrary.simpleMessage("Type task name..."),
    "withLabel" : MessageLookupByLibrary.simpleMessage("with")
  };
}
