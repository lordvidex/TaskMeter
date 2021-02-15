import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Settings extends Equatable {
  int longBreakIntervals;
  Duration shortBreak;
  Duration longBreak;
  Duration totalTime;
  String language;
  bool isDarkMode;

  /// Time of upload to both database and server which is used
  /// to distinguish a current data from an old data.
  DateTime timeOfUpload;

  Settings({
    @required this.totalTime,
    @required this.longBreakIntervals,
    @required this.shortBreak,
    @required this.longBreak,
    //TODO: add localization
    this.language = "en-US",
    this.isDarkMode,
    this.timeOfUpload,
  });

  ///shortBreak and longBreaks are stored in seconds [int] in shared_preferences
  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        totalTime: Duration(seconds: json['total_time']),
        longBreakIntervals: json['long_break_intervals'],
        language: json['language'],
        isDarkMode: json['is_dark_mode'],
        shortBreak: Duration(seconds: json['short_break']),
        longBreak: Duration(seconds: json['long_break']),
        timeOfUpload: DateTime.tryParse(json['time_of_upload']),
      );

  factory Settings.defaultSettings() => Settings(
      longBreakIntervals: 3,
      totalTime: Duration(minutes: 30),
      shortBreak: Duration(minutes: 1),
      longBreak: Duration(minutes: 5),
      isDarkMode: null,
      language: "en-US");
  Map<String, dynamic> toJson() => {
        'total_time': totalTime.inSeconds,
        'long_break_intervals': longBreakIntervals,
        'short_break': shortBreak.inSeconds,
        'long_break': longBreak.inSeconds,
        'is_dark_mode': isDarkMode,
        'language': language,
        'time_of_upload': timeOfUpload?.toIso8601String(),
      };
  void setUpdateTime(DateTime dateTime) {
    timeOfUpload = DateTime.now();
  }

  @override
  List<Object> get props => [
        longBreakIntervals,
        shortBreak,
        longBreak,
        totalTime,
        language
      ];
}
