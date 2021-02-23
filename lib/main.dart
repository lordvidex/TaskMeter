import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants.dart';
import 'injection_container.dart' as di;
import 'models/app_theme.dart';
import 'providers/settings_provider.dart';
import 'providers/task_group_provider.dart';
import 'screens/create_task_group_screen.dart';
import 'screens/error_screen.dart';
import 'screens/select_theme_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/task_group_description_screen.dart';
import 'screens/task_group_screen.dart';
import 'screens/task_timer_screen.dart';

void main() async {
  //TODO: loading splash screen HERE - (a brief loading animation to be precise)
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => di.sl<SettingsProvider>(),
        ),
        ChangeNotifierProvider<TaskGroupProvider>(
          create: (_) => di.sl<TaskGroupProvider>(),
        ),
      ],
      child: NewWidget(),
    );
  }
}

class NewWidget extends StatelessWidget {
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
          home: TaskGroupScreen(),
          routes: {
            TaskGroupScreen.routeName: (_) => TaskGroupScreen(),
            TaskTimerScreen.routeName: (_) => TaskTimerScreen(),
            TaskGroupDescriptionScreen.routeName: (_) =>
                TaskGroupDescriptionScreen(),
            SettingsScreen.routeName: (_) => SettingsScreen(),
            ErrorScreen.routeName: (_) => ErrorScreen(),
            CreateTaskGroupScreen.routeName: (_) => CreateTaskGroupScreen(),
            SelectThemeScreen.routeName: (_) => SelectThemeScreen(),
          }),
    );
  }
}
