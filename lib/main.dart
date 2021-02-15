import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/screens/settings_screen.dart';

import 'core/constants.dart';
import 'injection_container.dart' as di;
import 'providers/settings_provider.dart';
import 'providers/task_group_provider.dart';
import 'screens/create_task_group_screen.dart';
import 'screens/error_screen.dart';
import 'screens/task_group_description_screen.dart';
import 'screens/task_group_screen.dart';
import 'screens/task_timer_screen.dart';

void main() async {
  //TODO: splash screen here
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
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Constants.kThemeData,
          darkTheme: Constants.kDarkThemeData,
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
          }),
    );
  }
}
