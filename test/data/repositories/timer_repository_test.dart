import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/data/repositories/timer_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TimerRepository timerRepo;
  setUp(() {
    timerRepo = TimerRepository();
  });
  test(
      'should return a Stream counting down from Duration `t` to Duration.zero',
      () {
    // arrange
    final duration = Duration(minutes: 1);
    // act
    final stream = timerRepo.timerTicker(duration);
    // assert
    expect(
        stream,
        emitsInOrder(
            List<Duration>.generate(60, (x) => Duration(seconds: 60 - x - 1))));
  }, timeout: Timeout(Duration(seconds: 61)));
  test('should return all the rive files when loadRiveFiles is called',
      () async {
    // arrange

    // act
    await timerRepo.loadRiveFiles();
    // assert
    expect(timerRepo.sandClocks.length, 11);
    expect(timerRepo.sandClocks[0].artboards.length, 1);
  });
}
