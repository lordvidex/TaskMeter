// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static m0(hours) => "${Intl.plural(hours, zero: '', one: '${hours} Час ', few: '${hours} Часа ', other: '${hours} Часов ')}";

  static m1(x) => "${Intl.plural(x, one: '${x} интервал', few: '${x} интервала', other: '${x} интервалов')}";

  static m2(minutes) => "${Intl.plural(minutes, zero: '${minutes} минут ', one: '${minutes} минута ', few: '${minutes} минуты ', other: '${minutes} минут ')}";

  static m3(seconds) => "${Intl.plural(seconds, zero: '', one: '${seconds} Секунда', few: '${seconds} Секунды', other: '${seconds} Секунд')}";

  static m4(x) => "${Intl.plural(x, zero: '${x} задач', one: '${x} задача', few: '${x} задачи', other: '${x} задачи')}";

  static m5(theme) => "${Intl.select(theme, {'Dark': 'Тёмная', 'Light': 'Светлая', 'System': 'Системная', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about" : MessageLookupByLibrary.simpleMessage("О нас"),
    "add" : MessageLookupByLibrary.simpleMessage("Добавьте"),
    "addTask" : MessageLookupByLibrary.simpleMessage("Добавьте задачу"),
    "and" : MessageLookupByLibrary.simpleMessage("и"),
    "appTheme" : MessageLookupByLibrary.simpleMessage("Тема приложения"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Отменить"),
    "click" : MessageLookupByLibrary.simpleMessage("Нажмите "),
    "clickOn" : MessageLookupByLibrary.simpleMessage("Нажми на "),
    "create" : MessageLookupByLibrary.simpleMessage("Создать"),
    "createTaskGroup" : MessageLookupByLibrary.simpleMessage("Создайте группа задач"),
    "dataNotSaved" : MessageLookupByLibrary.simpleMessage("Данные не сохранены!"),
    "dataNotSavedDesc1" : MessageLookupByLibrary.simpleMessage("У вас есть некоторые несохраненные данные, вернитесь назад и нажмите "),
    "dataNotSavedDesc2" : MessageLookupByLibrary.simpleMessage(" в правом верхнем углу сохранить!"),
    "delete" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "difficulty" : MessageLookupByLibrary.simpleMessage("Cложность"),
    "discard" : MessageLookupByLibrary.simpleMessage("Отбросить"),
    "duration" : MessageLookupByLibrary.simpleMessage("Время"),
    "edit" : MessageLookupByLibrary.simpleMessage("Изменить"),
    "emptyTaskGroupText" : MessageLookupByLibrary.simpleMessage("список групп задач пуст"),
    "enterTaskName" : MessageLookupByLibrary.simpleMessage("Введите название задачи"),
    "feedback" : MessageLookupByLibrary.simpleMessage("Отзыв"),
    "generalSettings" : MessageLookupByLibrary.simpleMessage("Общие Настройки"),
    "hours" : m0,
    "intervals" : m1,
    "language" : MessageLookupByLibrary.simpleMessage("Язык"),
    "longBreak" : MessageLookupByLibrary.simpleMessage("Большой перерыв"),
    "longBreakAfter" : MessageLookupByLibrary.simpleMessage("Длинный перерыв после"),
    "longBreakDuration" : MessageLookupByLibrary.simpleMessage("Время длинного перерыва"),
    "min" : MessageLookupByLibrary.simpleMessage("мин."),
    "minutes" : m2,
    "progress" : MessageLookupByLibrary.simpleMessage("прогресс"),
    "rate" : MessageLookupByLibrary.simpleMessage("Оценить в app store"),
    "seconds" : m3,
    "selectTheme" : MessageLookupByLibrary.simpleMessage("Выбрайте Тема"),
    "shortBreak" : MessageLookupByLibrary.simpleMessage("Маленький перерыв"),
    "shortBreakDuration" : MessageLookupByLibrary.simpleMessage("Время короткого перерыва"),
    "system" : MessageLookupByLibrary.simpleMessage("Системы"),
    "taskCount" : m4,
    "taskGroupName" : MessageLookupByLibrary.simpleMessage("Название группы задач"),
    "taskGroupNameErrorText" : MessageLookupByLibrary.simpleMessage("Введите правильное название задачи"),
    "taskGroups" : MessageLookupByLibrary.simpleMessage("Группы задач"),
    "taskName" : MessageLookupByLibrary.simpleMessage("Название задачи"),
    "theme" : MessageLookupByLibrary.simpleMessage("Тема"),
    "themeType" : m5,
    "toAddNewTask" : MessageLookupByLibrary.simpleMessage(" чтобы добавить новую задачу"),
    "toAddNewTaskGroup" : MessageLookupByLibrary.simpleMessage("чтобы добавить новую группу задач"),
    "typeTaskName" : MessageLookupByLibrary.simpleMessage("Введите задачу...")
  };
}
