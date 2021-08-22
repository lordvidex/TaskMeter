import 'package:equatable/equatable.dart';

import 'app_theme.dart';

// Keys
const TOTAL_TIME = 'total_time';
const LONG_BREAK_INTERVALS = 'long_break_intervals';
const LANGUAGE = 'language';
const APP_THEME = 'app_theme';
const SHORT_BREAK = 'short_break';
const LONG_BREAK = 'long_break';
const TIME_OF_UPLOAD = 'time_of_upload';

class Settings extends Equatable {
  int? longBreakIntervals;
  Duration shortBreak;
  Duration longBreak;
  Duration totalTime;
  // en && ru
  String? language;
  AppTheme? appTheme;

  /// Time of upload to both database and server which is used
  /// to distinguish a current data from an old data.
  DateTime? timeOfUpload;

  Settings({
    required this.totalTime,
    required this.longBreakIntervals,
    required this.shortBreak,
    required this.longBreak,
    this.language,
    this.appTheme,
    this.timeOfUpload,
  });

  ///shortBreak and longBreaks are stored in seconds [int] in shared_preferences
  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        totalTime: Duration(seconds: json[TOTAL_TIME]),
        longBreakIntervals: json[LONG_BREAK_INTERVALS],
        language: json[LANGUAGE],
        appTheme: AppTheme.values[json[APP_THEME]],
        shortBreak: Duration(seconds: json[SHORT_BREAK]),
        longBreak: Duration(seconds: json[LONG_BREAK]),
        timeOfUpload: DateTime.tryParse(json[TIME_OF_UPLOAD]),
      );

  factory Settings.defaultSettings() => Settings(
      longBreakIntervals: 3,
      totalTime: Duration(minutes: 30),
      shortBreak: Duration(minutes: 1),
      longBreak: Duration(minutes: 5),
      appTheme: AppTheme.System);
  Map<String, dynamic> toJson() => {
        TOTAL_TIME: totalTime.inSeconds,
        LONG_BREAK_INTERVALS: longBreakIntervals,
        SHORT_BREAK: shortBreak.inSeconds,
        LONG_BREAK: longBreak.inSeconds,
        APP_THEME: appTheme!.index,
        LANGUAGE: language,
        TIME_OF_UPLOAD: timeOfUpload?.toIso8601String(),
      };
  void setUpdateTime(DateTime dateTime) {
    timeOfUpload = DateTime.now();
  }

  Settings copyWith({
    Duration? totalTime,
    int? longBreakIntervals,
    Duration? shortBreak,
    Duration? longBreak,
    String? language,
    AppTheme? appTheme,
    DateTime? timeOfUpload,
  }) =>
      Settings(
          longBreak: longBreak ?? this.longBreak,
          shortBreak: shortBreak ?? this.shortBreak,
          longBreakIntervals: longBreakIntervals ?? this.longBreakIntervals,
          totalTime: totalTime ?? this.totalTime,
          appTheme: appTheme ?? this.appTheme,
          language: language ?? this.language,
          timeOfUpload: timeOfUpload ?? this.timeOfUpload);

  @override
  List<Object?> get props =>
      [longBreakIntervals, shortBreak, longBreak, totalTime, language];
}
