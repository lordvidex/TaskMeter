import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/core/constants.dart';
import 'package:task_meter/presentation/screens/create_task_group_screen.dart';
import 'package:task_meter/presentation/screens/settings_screen.dart';
import 'package:task_meter/presentation/widgets/task_timer/action_button.dart';

import '../../../locale/locales.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/task_group_provider.dart';
import 'data_container.dart';
import 'task_group_widget.dart';

class TaskGroupListWidget extends StatelessWidget {
  const TaskGroupListWidget({
    Key key,
    @required this.provider,
    @required this.appLocale,
  }) : super(key: key);

  final AuthenticationProvider provider;
  final AppLocalizations appLocale;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return RefreshIndicator(
      onRefresh: context.read<TaskGroupProvider>().loadTaskGroups,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(0, 10, 30, 10)),
                  child: Icon(Icons.account_circle_outlined,
                      color: isDarkMode ? Colors.white : Constants.appNavyBlue,
                      size: 24),
                  onPressed: () {},
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 10)),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SettingsScreen.routeName),
                  child: SvgPicture.asset('assets/icons/settings.svg',
                      width: 29,
                      height: 29,
                      color: isDarkMode ? Colors.white : Constants.appNavyBlue),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Task Meter',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Consumer<TaskGroupProvider>(
                  builder: (ctx, mProvider, _) => DataContainer(
                      label: 'Task completed',
                      text: '${mProvider.tasksCompleted}',
                      isDarkMode: isDarkMode),
                )),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Consumer<TaskGroupProvider>(
                  builder: (ctx, mProvider, _) => DataContainer(
                      label: 'Tracked Hours',
                      text: mProvider.trackedHours.toStringAsFixed(1),
                      isDarkMode: isDarkMode),
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Active Tasks',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            Expanded(
              child: Consumer<TaskGroupProvider>(
                builder: (ctx, provider, child) {
                  final groups = provider.taskGroups
                    ..retainWhere((g) => !g.isDeleted);
                  if (groups.isEmpty)
                    return child;
                  else
                    return ListView.builder(
                      itemBuilder: (ctx, index) => TaskGroupWidget(
                        taskGroup: groups[index],
                        isDarkMode: isDarkMode,
                      ),
                      itemCount: groups.length,
                    );
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/empty.png',
                        height: 240,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text('It\'s empty here,')),
                      Text('Create task to continue')
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ActionButton(
                  padding: const EdgeInsets.fromLTRB(67, 14, 67, 14),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(CreateTaskGroupScreen.routeName),
                  fillColor: Constants.appBlue,
                  text: appLocale.createTask),
            )
          ]),
        ),
      ),
    );
  }
}
