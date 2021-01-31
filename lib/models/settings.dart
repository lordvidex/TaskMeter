import 'package:meta/meta.dart';

class Settings {
  final int interval;
  final Duration shortBreak;
  final Duration longBreak;
  const Settings({
    @required this.interval,
    @required this.shortBreak,
    @required this.longBreak,
  });

  ///shortBreak and longBreaks are stored in seconds [int] in shared_preferences
  factory Settings.fromMap(Map<String, dynamic> json) {
    return Settings(
      interval: json['interval'],
      shortBreak: Duration(seconds: json['short_break']),
      longBreak: Duration(seconds: json['long_break']),
    );
  }
  factory Settings.defaultSettings() {
    return Settings(
      interval: 3,
      shortBreak: Duration(minutes: 1),
      longBreak: Duration(minutes: 5),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'interval': interval,
      'short_break': shortBreak.inSeconds,
      'long_break': longBreak.inSeconds,
    };
  }
}
