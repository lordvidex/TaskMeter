import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_meter/presentation/bloc/size_bloc.dart';

import 'core/network/network_info.dart';
import 'data/datasources/local_storage.dart';
import 'data/datasources/remote_storage.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/repositories/task_group_repository.dart';
import 'data/repositories/timer_repository.dart';
import 'domain/usecases/auto_login_usecase.dart';
import 'domain/usecases/email_signin_usecase.dart';
import 'domain/usecases/email_signup_usecase.dart';
import 'domain/usecases/google_signin_usecase.dart';
import 'domain/usecases/google_signup_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'presentation/bloc/timer_bloc.dart';
import 'presentation/providers/authentication_provider.dart';
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
  sl.registerFactory(() => SizeBloc());
  //! Providers
  sl.registerLazySingleton(() => SettingsProvider(settingsRepo: sl()));
  sl.registerLazySingleton(() => TaskGroupProvider(taskGroupRepo: sl()));
  sl.registerLazySingleton(() => AuthenticationProvider(
        autoLoginUseCase: sl(),
        emailSignInUseCase: sl(),
        emailSignUpUseCase: sl(),
        logoutUseCase: sl(),
        googleSignInUseCase: sl(),
        googleSignUpUseCase: sl(),
      ));

  //! Usecases
  sl.registerLazySingleton(() => EmailSignInUseCase(authRepo: sl()));
  sl.registerLazySingleton(() => EmailSignUpUseCase(authRepo: sl()));
  sl.registerLazySingleton(() => LogOutUsecase(authRepo: sl()));
  sl.registerLazySingleton(() => AutoLoginUseCase(authRepo: sl()));
  sl.registerLazySingleton(() => GoogleSignInUseCase(authRepo: sl()));
  sl.registerLazySingleton(() => GoogleSignUpUseCase(authRepo: sl()));

  //! repositories
  sl.registerLazySingleton(() => TimerRepository());
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(localStorage: sl(), remoteStorage: sl()));
  sl.registerLazySingleton<TaskGroupRepository>(
      () => TaskGroupRepositoryImpl(localStorage: sl(), remoteStorage: sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
            localStorage: sl(),
            remoteStorage: sl(),
            networkInfo: sl(),
          ));

  //! data sources
  sl.registerLazySingleton<LocalStorage>(
      () => LocalStorageImpl(sharedPreferences: sl(), firebaseAuth: sl()));
  sl.registerLazySingleton<RemoteStorage>(() => RemoteStorageImpl(
      firebaseAuth: sl(), firestore: sl(), googleSignIn: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! external
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

Future<void> _loadData() async {
  await sl.get<AuthenticationProvider>().autoLogin();
  await sl.get<SettingsProvider>().loadSettings();
  await sl.get<TaskGroupProvider>().loadTaskGroups();
}
