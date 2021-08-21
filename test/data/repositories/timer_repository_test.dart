import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/data/repositories/timer_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TimerRepository timerRepo;
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
}
