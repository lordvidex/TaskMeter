String durationInLetters(Duration duration) {
  String twoDigits(int n) => n.toString();
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return (_numberCase((twoDigits(duration.inHours)), ' Hour') +
      (_numberCase(twoDigitMinutes, ' Minute')) +
      (_numberCase(twoDigitSeconds, ' Second')));
}

//so that if the numbre is 0 we don't print it and if bigger than 1 we add 's' for the plural
String _numberCase(String time, String unit) {
  if (time == "0") {
    return '';
  } else if (time == "1") {
    return (time + unit + ' ');
  }
  return (time + unit + 's ');
}
