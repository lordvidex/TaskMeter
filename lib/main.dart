import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants.dart';
import 'domain/models/app_theme.dart';
import 'injection_container.dart' as di;
import 'locale/locales.dart';
import 'presentation/bloc/timer_bloc.dart';
import 'presentation/providers/authentication_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/providers/task_group_provider.dart';
import 'presentation/screens/authentication_screen.dart';
import 'presentation/screens/create_task_group_screen.dart';
import 'presentation/screens/error_screen.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/screens/task_group_description_screen.dart';
import 'presentation/screens/task_group_screen.dart';
import 'presentation/screens/task_timer_screen.dart';
import 'presentation/screens/welcome_screen.dart';

void main() async {
  //TODO: loading splash screen HERE - (a brief loading animation to be precise)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          lazy: true,
          create: (_) => di.sl<AuthenticationProvider>(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => di.sl<SettingsProvider>(),
        ),
        ChangeNotifierProvider<TaskGroupProvider>(
          create: (_) => di.sl<TaskGroupProvider>(),
        ),
        BlocProvider(create: (_) => di.sl<TimerBloc>())
      ],
      child: RootWidget(),
    );
  }
}

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
        builder: (ctx, provider, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Constants.kThemeData,
            darkTheme: Constants.kDarkThemeData,
            themeMode: provider.settings.appTheme == AppTheme.System
                ? ThemeMode.system
                : provider.settings.appTheme == AppTheme.Light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            title: 'Task Meter',
            locale: provider.settings.language == null
                ? null
                : Locale(provider.settings.language),
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('ru', ''), // Russian, no country code
            ],
            home: provider.isFirstTimeUser ? WelcomeScreen() : TaskGroupScreen(),
            routes: {
              TaskGroupScreen.routeName: (_) => TaskGroupScreen(),
              AuthenticationScreen.routeName: (_) => AuthenticationScreen(),
              TaskTimerScreen.routeName: (_) => TaskTimerScreen(),
              TaskGroupDescriptionScreen.routeName: (_) =>
                  TaskGroupDescriptionScreen(),
              SettingsScreen.routeName: (_) => SettingsScreen(),
              ErrorScreen.routeName: (_) => ErrorScreen(),
              CreateTaskGroupScreen.routeName: (_) => CreateTaskGroupScreen(),
            }),
      );
    }
}
