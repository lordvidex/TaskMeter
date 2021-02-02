import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_meter/providers/task_group_provider.dart';

import 'bloc/timer_bloc.dart';
import 'data/local_storage.dart';
import 'providers/settings_provider.dart';
import 'repositories/settings_repository.dart';
import 'repositories/timer_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory(() => TimerBloc(timerRepo: sl()));
  //! Providers
  sl.registerLazySingleton(() => SettingsProvider(settingsRepo: sl()));

  //! repositories
  sl.registerLazySingleton(() => TimerRepository());
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(localStorage: sl()));

  //! data sources
  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl(sl()));

  //! external
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  await initSettings();
}

Future<void> initSettings() async {
  await sl.get<SettingsProvider>().loadSettings();
}
