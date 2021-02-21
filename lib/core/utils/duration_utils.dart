class DurationUtils {
  ///converts Duration to String in readable format e.g
  /// x `hours` y `minutes` z `seconds`
  static String durationToReadableString(Duration duration) {
    final twoDigitMinutes = duration.inMinutes.remainder(60);
    final twoDigitSeconds = duration.inSeconds.remainder(60);
    return (_pluralFormatter((duration.inHours), 'Hour') +
        (_pluralFormatter(twoDigitMinutes, 'Minute')) +
        (_pluralFormatter(twoDigitSeconds, 'Second')));
  }

  ///converts Duration to String in clock format e.g
  /// xx:yy:zz representing hours:minutes:seconds
  static String durationToClockString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  /// @returns an empty string if `time` is 0\
  /// @returns singular string if `time` is 1\
  /// @returns plural string if `time` is greater than 1
  static String _pluralFormatter(int time, String unit) {
    if (time == 0) {
      return '';
    } else if (time == 1) {
      return '$time $unit ';
    }
    return '$time ${unit}s ';
  }

  static int liveDurationQuotient(Duration timeRemaining, Duration totalTime) {
    return 10 - (timeRemaining.inSeconds * 10 / totalTime.inSeconds).round();
  }
}
