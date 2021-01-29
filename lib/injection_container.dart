import 'package:get_it/get_it.dart';
import 'package:task_meter/repositories/timer_repository.dart';

import 'bloc/timer_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //Blocs
  sl.registerFactory(() => TimerBloc(timerRepo: sl()));

  // repositories
  sl.registerLazySingleton(() => TimerRepository());
}
