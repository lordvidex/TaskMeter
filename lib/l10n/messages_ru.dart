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

  static m0(socialPlatform) => "Продолжайте с ${socialPlatform}";

  static m1(hours) => "${Intl.plural(hours, zero: '${hours} Часов ', one: '${hours} Час ', few: '${hours} Часа ', many: '${hours} Часов ', other: '${hours} Часов ')}";

  static m2(x) => "${Intl.plural(x, zero: '${x} интервалов', one: '${x} интервал', few: '${x} интервала', many: '${x} интервалов', other: '${x} интервалов')}";

  static m3(minutes) => "${Intl.plural(minutes, zero: '${minutes} минут', one: '${minutes} минута ', few: '${minutes} минуты ', many: '${minutes} минут', other: '${minutes} минут ')}";

  static m4(seconds) => "${Intl.plural(seconds, zero: '', one: '${seconds} Секунда', few: '${seconds} Секунды', many: '${seconds} Секунд', other: '${seconds} Секунд')}";

  static m5(x) => "${Intl.plural(x, zero: '${x} задач', one: '${x} задача', few: '${x} задачи', many: '${x} задачи', other: '${x} задачи')}";

  static m6(done, total) => "${Intl.plural(total, zero: '${done} из ${total} заданий выполнено', one: '${done} из ${total} задания выполнено', few: '${done} из ${total} заданий выполнено', many: '${done} из ${total} заданий выполнено', other: '${done} из ${total} заданий выполнено')}";

  static m7(theme) => "${Intl.select(theme, {'Dark': 'Тёмная', 'Light': 'Светлая', 'System': 'Системная', })}";

  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about" : MessageLookupByLibrary.simpleMessage("О нас"),
    "activeTasks" : MessageLookupByLibrary.simpleMessage("Активные задачи"),
    "add" : MessageLookupByLibrary.simpleMessage("Добавьте"),
    "addSubTask" : MessageLookupByLibrary.simpleMessage("Добавить подзадачу"),
    "and" : MessageLookupByLibrary.simpleMessage("и"),
    "appTheme" : MessageLookupByLibrary.simpleMessage("Тема приложения"),
    "breakComplete" : MessageLookupByLibrary.simpleMessage("Перерыв завершен"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Отменить"),
    "checkInbox" : MessageLookupByLibrary.simpleMessage("Проверьте свой почтовый ящик, чтобы установить новый пароль для этого аккаунта"),
    "complete" : MessageLookupByLibrary.simpleMessage("завершите"),
    "continueAsGuest" : MessageLookupByLibrary.simpleMessage("Продолжить без аутентификации"),
    "continueLabel" : MessageLookupByLibrary.simpleMessage("Продолжать"),
    "continueWith" : m0,
    "createTask" : MessageLookupByLibrary.simpleMessage("Создать задачу"),
    "createTaskToContinue" : MessageLookupByLibrary.simpleMessage("Создайте задачу"),
    "dataNotSaved" : MessageLookupByLibrary.simpleMessage("Данные не сохранены!"),
    "dataNotSavedDesc1" : MessageLookupByLibrary.simpleMessage("У вас есть некоторые несохраненные данные, вернитесь назад и нажмите "),
    "dataNotSavedDesc2" : MessageLookupByLibrary.simpleMessage(" в правом верхнем углу сохранить!"),
    "delete" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "difficulty" : MessageLookupByLibrary.simpleMessage("Cложность"),
    "discard" : MessageLookupByLibrary.simpleMessage("Отбросить"),
    "durationInMinutes" : MessageLookupByLibrary.simpleMessage("Время (в минутах)"),
    "edit" : MessageLookupByLibrary.simpleMessage("Изменить"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Редактировать"),
    "emptyErrorMessage" : MessageLookupByLibrary.simpleMessage("Пожалуйста, введите текст"),
    "emptyHere" : MessageLookupByLibrary.simpleMessage("Здесь пусто"),
    "enterEmail" : MessageLookupByLibrary.simpleMessage("Введите адрес электронной почты"),
    "enterPassword" : MessageLookupByLibrary.simpleMessage("Пароль"),
    "enterRecoveryMail" : MessageLookupByLibrary.simpleMessage("Введите адрес электронной почты для восстановления"),
    "enterTaskName" : MessageLookupByLibrary.simpleMessage("Введите название задачи"),
    "errorOccured" : MessageLookupByLibrary.simpleMessage("Произошла ошибка!"),
    "feedback" : MessageLookupByLibrary.simpleMessage("Отзыв"),
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "generalSettings" : MessageLookupByLibrary.simpleMessage("Общие Настройки"),
    "getStarted" : MessageLookupByLibrary.simpleMessage("Давайте начнем"),
    "hours" : m1,
    "intervals" : m2,
    "language" : MessageLookupByLibrary.simpleMessage("Язык"),
    "languageAndAppearance" : MessageLookupByLibrary.simpleMessage("Язык и внешность"),
    "longBreak" : MessageLookupByLibrary.simpleMessage("Большой перерыв"),
    "longBreakAfter" : MessageLookupByLibrary.simpleMessage("Длинный перерыв после"),
    "longBreakDuration" : MessageLookupByLibrary.simpleMessage("Время длинного перерыва"),
    "longBreakIntervals" : MessageLookupByLibrary.simpleMessage("Интервал большого перерыва"),
    "min" : MessageLookupByLibrary.simpleMessage("мин."),
    "minutes" : m3,
    "newAccount" : MessageLookupByLibrary.simpleMessage("Новый аккаунт"),
    "newAccountAgreement" : MessageLookupByLibrary.simpleMessage("Нажав кнопку Продолжить, вы соглашаетесь создать новый аккаунт со следующими учетными данными."),
    "next" : MessageLookupByLibrary.simpleMessage("Дальше"),
    "nextTask" : MessageLookupByLibrary.simpleMessage("К след. задаче"),
    "pause" : MessageLookupByLibrary.simpleMessage("Пауза"),
    "progress" : MessageLookupByLibrary.simpleMessage("прогресс"),
    "rate" : MessageLookupByLibrary.simpleMessage("Оценить в app store"),
    "resume" : MessageLookupByLibrary.simpleMessage("Продолжайте"),
    "seconds" : m4,
    "selectTheme" : MessageLookupByLibrary.simpleMessage("Выбрайте Тема"),
    "sendRecoveryMail" : MessageLookupByLibrary.simpleMessage("Отправить письмо для восстановления"),
    "settings" : MessageLookupByLibrary.simpleMessage("Настройки"),
    "shortBreak" : MessageLookupByLibrary.simpleMessage("Маленький перерыв"),
    "shortBreakDuration" : MessageLookupByLibrary.simpleMessage("Время короткого перерыва"),
    "signIn" : MessageLookupByLibrary.simpleMessage("Войдите"),
    "signup" : MessageLookupByLibrary.simpleMessage("Зарегистрируйтесь"),
    "subTask" : MessageLookupByLibrary.simpleMessage("Подзадача"),
    "system" : MessageLookupByLibrary.simpleMessage("Системы"),
    "takeBreak" : MessageLookupByLibrary.simpleMessage("отдохнуть"),
    "taskComplete" : MessageLookupByLibrary.simpleMessage("Задача завершена"),
    "taskCompleted" : MessageLookupByLibrary.simpleMessage("Задача выполнена"),
    "taskCount" : m5,
    "taskGroupNameErrorText" : MessageLookupByLibrary.simpleMessage("Введите правильное название задачи"),
    "taskName" : MessageLookupByLibrary.simpleMessage("Название задачи"),
    "taskRatioDesc" : m6,
    "tasks" : MessageLookupByLibrary.simpleMessage("Задачи"),
    "termsAndServices" : MessageLookupByLibrary.simpleMessage("Продолжая, вы подтверждаете свое согласие с нашими Условиями предоставления услуг и политикой конфиденциальности"),
    "theme" : MessageLookupByLibrary.simpleMessage("Тема"),
    "themeType" : m7,
    "trackedHours" : MessageLookupByLibrary.simpleMessage("Отслеживаемые часы"),
    "typeTaskName" : MessageLookupByLibrary.simpleMessage("Введите задачу..."),
    "withLabel" : MessageLookupByLibrary.simpleMessage("с")
  };
}
