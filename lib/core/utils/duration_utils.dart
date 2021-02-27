import '../../locale/locales.dart';

class DurationUtils {
  ///converts Duration to String in readable format e.g
  /// x `hours` y `minutes` z `seconds`
  static String durationToReadableString(Duration duration, AppLocalizations appLocale) {
    
    final twoDigitMinutes = duration.inMinutes.remainder(60);
    final twoDigitSeconds = duration.inSeconds.remainder(60);
    return (appLocale.hours(duration.inHours) +
     (appLocale.minutes(twoDigitMinutes)) +
       (appLocale.seconds(twoDigitSeconds)));
  }

  ///converts Duration to String in clock format e.g
  /// xx:yy:zz representing hours:minutes:seconds
  static String durationToClockString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static int liveDurationQuotient(Duration timeRemaining, Duration totalTime) {
    return 10 - (timeRemaining.inSeconds * 10 / totalTime.inSeconds).round();
  }
}
