import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class TimerRepository {
  List<RiveFile> _sandClocks = [];

  List<RiveFile> get sandClocks => [..._sandClocks];

  ///@returns a `Duration` every second and reduces it's value
  ///by `1 second`
  Stream<Duration> timerTicker(Duration time) {
    return Stream.periodic(
            Duration(seconds: 1), (x) => time - Duration(seconds: 1 + x))
        .take(time.inSeconds);
  }

  Future<void> loadRiveFiles() async {
    for (var i = 0; i <= 10; i++) {
      RiveFile file = RiveFile();
      final bytes = await rootBundle.load('assets/animations/$i.riv');
      if (file.import(bytes)) {
        _sandClocks.add(file);
      } else {
        print('Failed to read .riv file');
      }
    }
  }
}
