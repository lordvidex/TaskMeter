import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'data/datasources/local_storage.dart';
import 'data/datasources/remote_storage.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/repositories/task_group_repository.dart';
import 'data/repositories/timer_repository.dart';
import 'domain/usecases/email_signin_usecase.dart';
import 'domain/usecases/email_signup_usecase.dart';
import 'presentation/bloc/timer_bloc.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/providers/task_group_provider.dart';

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

  //! Usecases
  sl.registerLazySingleton(() => EmailSignInUseCase(authRepo: sl()));
  sl.registerLazySingleton(() => EmailSignUpUseCase(authRepo: sl()));

  //! repositories
  sl.registerLazySingleton(() => TimerRepository());
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(localStorage: sl(), remoteStorage: sl()));
  sl.registerLazySingleton<TaskGroupRepository>(
      () => TaskGroupRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
            localStorage: sl(),
            remoteStorage: sl(),
            networkInfo: sl(),
          ));

  //! data sources
  sl.registerLazySingleton<LocalStorage>(
      () => LocalStorageImpl(sharedPreferences: sl(), firebaseAuth: sl()));
  sl.registerLazySingleton<RemoteStorage>(
      () => RemoteStorageImpl(firebaseAuth: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! external
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
  sl.registerLazySingleton(() => DataConnectionChecker());
}

Future<void> _loadData() async {
  await sl.get<SettingsProvider>().loadSettings();
  await sl.get<TaskGroupProvider>().loadTaskGroups();
  await sl.get<TimerRepository>().loadRiveFiles();
}
