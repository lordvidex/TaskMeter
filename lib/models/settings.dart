import 'package:meta/meta.dart';

class Settings {
  final int longBreakIntervals;
  final Duration shortBreak;
  final Duration longBreak;
  const Settings({
    @required this.longBreakIntervals,
    @required this.shortBreak,
    @required this.longBreak,
  });

  ///shortBreak and longBreaks are stored in seconds [int] in shared_preferences
  factory Settings.fromMap(Map<String, dynamic> json) {
    return Settings(
      longBreakIntervals: json['long_break_intervals'],
      shortBreak: Duration(seconds: json['short_break']),
      longBreak: Duration(seconds: json['long_break']),
    );
  }
  factory Settings.defaultSettings() {
    return Settings(
      longBreakIntervals: 3,
      shortBreak: Duration(minutes: 1),
      longBreak: Duration(minutes: 5),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'long_break_intervals': longBreakIntervals,
      'short_break': shortBreak.inSeconds,
      'long_break': longBreak.inSeconds,
    };
  }
}
