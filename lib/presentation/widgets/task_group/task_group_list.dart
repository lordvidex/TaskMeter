import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../locale/locales.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/task_group_provider.dart';
import '../../screens/create_task_group_screen.dart';
import '../../screens/settings_screen.dart';
import '../task_timer/action_button.dart';
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
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    backgroundColor:
                        isDarkMode ? Colors.black : Constants.appLightBlue,
                    floating: true,
                    leading: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(0, 10, 30, 10)),
                      child: Icon(Icons.account_circle_outlined,
                          color:
                              isDarkMode ? Colors.white : Constants.appNavyBlue,
                          size: 24),
                      onPressed: () {},
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(30, 10, 0, 10)),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(SettingsScreen.routeName),
                        child: SvgPicture.asset('assets/icons/settings.svg',
                            width: 29,
                            height: 29,
                            color: isDarkMode
                                ? Colors.white
                                : Constants.appNavyBlue),
                      )
                    ],
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.only(top: 8, bottom: 18),
                      sliver: SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Task Meter',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                  SliverToBoxAdapter(
                    child: Row(
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
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      sliver: SliverToBoxAdapter(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Active Tasks',
                              style: TextStyle(fontSize: 18),
                            )),
                      )),
                  Consumer<TaskGroupProvider>(
                    builder: (ctx, provider, child) {
                      final groups = provider.activeTasks;
                      if (groups.isEmpty)
                        return child;
                      else
                        return SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (ctx, index) => index != groups.length
                                    ? TaskGroupWidget(
                                        taskGroup: groups[index],
                                        isDarkMode: isDarkMode,
                                      )
                                    : Container(
                                        height: 30,
                                      ),
                                childCount: groups.length + 1));
                    },
                    child: SliverToBoxAdapter(
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
                  )
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 82,
                    padding: const EdgeInsets.symmetric(horizontal: 73),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ActionButton(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(CreateTaskGroupScreen.routeName),
                          fillColor: Constants.appBlue,
                          text: appLocale.createTask),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: isDarkMode
                                ? [Colors.black.withOpacity(0), Colors.black]
                                : [
                                    Constants.appLightBlue.withOpacity(0.4),
                                    Constants.appLightBlue
                                  ])),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}