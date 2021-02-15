import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_meter/data/remote_storage.dart';

import 'bloc/timer_bloc.dart';
import 'data/local_storage.dart';
import 'providers/settings_provider.dart';
import 'providers/task_group_provider.dart';
import 'repositories/settings_repository.dart';
import 'repositories/task_group_repository.dart';
import 'repositories/timer_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _registerComponents();

  await _loadData();
}

Future<void> _registerComponents() async {
  //! Blocs
  sl.registerFactory(() => TimerBloc(timerRepo: sl()));
  //! Providers
  sl.registerLazySingleton(() => SettingsProvider(settingsRepo: sl()));
  sl.registerLazySingleton(() => TaskGroupProvider(taskGroupRepo: sl()));

  //! repositories
  sl.registerLazySingleton(() => TimerRepository());
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(localStorage: sl(), remoteStorage: sl()));
  sl.registerLazySingleton<TaskGroupRepository>(
      () => TaskGroupRepositoryImpl(sl()));

  //! data sources
  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl(sl()));
  sl.registerLazySingleton<RemoteStorage>(() => RemoteStorageImpl());

  //! external
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
}

Future<void> _loadData() async {
  await sl.get<SettingsProvider>().loadSettings();
  await sl.get<TaskGroupProvider>().loadTaskGroups();
}
