import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants.dart';
import 'injection_container.dart' as di;
import 'providers/task_group_provider.dart';
import 'screens/add_task_group_screen.dart';
import 'screens/error_screen.dart';
import 'screens/task_group_description_screen.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskGroupProvider>(
          create: (_) => TaskGroupProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Constants.kThemeData,
          home: TaskGroupDescriptionScreen(),
          routes: {
            TaskGroupDescriptionScreen.routeName: (_) =>
                TaskGroupDescriptionScreen(),
            ErrorScreen.routeName: (_) => ErrorScreen(),
            AddTaskGroupScreen.routeName: (_) => AddTaskGroupScreen(),
          }),
    );
  }
}
