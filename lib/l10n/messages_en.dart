// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(hours) => "${Intl.plural(hours, zero: '', one: '${hours} Hour ', few: '${hours} Hours ', other: '${hours} Hours ')}";

  static m1(x) => "${Intl.plural(x, one: '${x} interval', few: '${x} intervals', other: '${x} intervals')}";

  static m2(minutes) => "${Intl.plural(minutes, zero: '', one: '${minutes} minute ', few: '${minutes} minutes ', other: '${minutes} minutes ')}";

  static m3(seconds) => "${Intl.plural(seconds, zero: '', one: '${seconds} second', few: '${seconds} seconds', other: '${seconds} seconds')}";

  static m4(x) => "${Intl.plural(x, zero: '${x} tasks', one: '${x} task', few: '${x} tasks', other: '${x} tasks')}";

  static m5(theme) => "${Intl.select(theme, {'Dark': 'Dark', 'Light': 'Light', 'System': 'System', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addTask" : MessageLookupByLibrary.simpleMessage("Add task"),
    "and" : MessageLookupByLibrary.simpleMessage("and"),
    "appTheme" : MessageLookupByLibrary.simpleMessage("App Theme"),
    "breakComplete" : MessageLookupByLibrary.simpleMessage("Break Complete"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "click" : MessageLookupByLibrary.simpleMessage("Click "),
    "clickOn" : MessageLookupByLibrary.simpleMessage("Click on "),
    "complete" : MessageLookupByLibrary.simpleMessage("Complete"),
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "createTaskGroup" : MessageLookupByLibrary.simpleMessage("Create task group"),
    "dataNotSaved" : MessageLookupByLibrary.simpleMessage("Data not saved!"),
    "dataNotSavedDesc1" : MessageLookupByLibrary.simpleMessage("You have some unsaved data, go back and click "),
    "dataNotSavedDesc2" : MessageLookupByLibrary.simpleMessage(" at the top-right to save!"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "difficulty" : MessageLookupByLibrary.simpleMessage("Difficulty"),
    "discard" : MessageLookupByLibrary.simpleMessage("Discard"),
    "duration" : MessageLookupByLibrary.simpleMessage("Duration"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "emptyTaskGroupText" : MessageLookupByLibrary.simpleMessage("Task group list is empty"),
    "enterEmail" : MessageLookupByLibrary.simpleMessage("Enter email address"),
    "enterPassword" : MessageLookupByLibrary.simpleMessage("Password"),
    "enterTaskName" : MessageLookupByLibrary.simpleMessage("Enter task name"),
    "feedback" : MessageLookupByLibrary.simpleMessage("Feedback"),
    "generalSettings" : MessageLookupByLibrary.simpleMessage("General Settings"),
    "hours" : m0,
    "intervals" : m1,
    "language" : MessageLookupByLibrary.simpleMessage("Language"),
    "longBreak" : MessageLookupByLibrary.simpleMessage("Long break"),
    "longBreakAfter" : MessageLookupByLibrary.simpleMessage("Long break after"),
    "longBreakDuration" : MessageLookupByLibrary.simpleMessage("Long break duration"),
    "min" : MessageLookupByLibrary.simpleMessage("min."),
    "minutes" : m2,
    "next" : MessageLookupByLibrary.simpleMessage("Next"),
    "nextTask" : MessageLookupByLibrary.simpleMessage("Next Task"),
    "pause" : MessageLookupByLibrary.simpleMessage("Pause"),
    "progress" : MessageLookupByLibrary.simpleMessage("progress"),
    "rate" : MessageLookupByLibrary.simpleMessage("Rate in the app store"),
    "resume" : MessageLookupByLibrary.simpleMessage("Resume"),
    "seconds" : m3,
    "selectTheme" : MessageLookupByLibrary.simpleMessage("Select Theme"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shortBreak" : MessageLookupByLibrary.simpleMessage("Short break"),
    "shortBreakDuration" : MessageLookupByLibrary.simpleMessage("Short break duration"),
    "signIn" : MessageLookupByLibrary.simpleMessage("Sign in"),
    "signup" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "system" : MessageLookupByLibrary.simpleMessage("System"),
    "takeBreak" : MessageLookupByLibrary.simpleMessage("Take Break"),
    "taskComplete" : MessageLookupByLibrary.simpleMessage("Task Complete"),
    "taskCount" : m4,
    "taskGroupName" : MessageLookupByLibrary.simpleMessage("Task group name"),
    "taskGroupNameErrorText" : MessageLookupByLibrary.simpleMessage("Enter a valid task group name"),
    "taskGroups" : MessageLookupByLibrary.simpleMessage("Task groups"),
    "taskName" : MessageLookupByLibrary.simpleMessage("Task name"),
    "theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "themeType" : m5,
    "toAddNewTask" : MessageLookupByLibrary.simpleMessage(" to add a new task"),
    "toAddNewTaskGroup" : MessageLookupByLibrary.simpleMessage("to add new Task group"),
    "typeTaskName" : MessageLookupByLibrary.simpleMessage("Type task name..."),
    "withLabel" : MessageLookupByLibrary.simpleMessage("with")
  };
}
