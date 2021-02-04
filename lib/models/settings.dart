import 'package:meta/meta.dart';

class Settings {
  final int longBreakIntervals;
  final Duration shortBreak;
  final Duration longBreak;
  final Duration totalTime;
  const Settings({
    this.totalTime,
    @required this.longBreakIntervals,
    @required this.shortBreak,
    @required this.longBreak,
  });

  ///shortBreak and longBreaks are stored in seconds [int] in shared_preferences
  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        totalTime: Duration(seconds: json['total_time']),
        longBreakIntervals: json['long_break_intervals'],
        shortBreak: Duration(seconds: json['short_break']),
        longBreak: Duration(seconds: json['long_break']),
      );

  factory Settings.defaultSettings() => Settings(
        longBreakIntervals: 3,
        totalTime: Duration(minutes: 30),
        shortBreak: Duration(minutes: 1),
        longBreak: Duration(minutes: 5),
      );
  Map<String, dynamic> toJson() => {
        'total_time': totalTime.inSeconds,
        'long_break_intervals': longBreakIntervals,
        'short_break': shortBreak.inSeconds,
        'long_break': longBreak.inSeconds,
      };
}
