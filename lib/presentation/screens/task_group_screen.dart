import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locale/locales.dart';
import '../providers/task_group_provider.dart';
import '../widgets/task_group/task_group_widget.dart';
import 'create_task_group_screen.dart';
import 'settings_screen.dart';

class TaskGroupScreen extends StatelessWidget {
  static const routeName = '/task-group';
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () =>
              Navigator.of(context).pushNamed(CreateTaskGroupScreen.routeName),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            leading: Icon(Icons.login, size: 30),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(SettingsScreen.routeName),
              )
            ],
            //expandedHeight: 120,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppLocalizations.of(context).taskGroups,
                  style: Theme.of(context).textTheme.headline1),
            ),
          ),
          Consumer<TaskGroupProvider>(
            builder: (ctx, provider, child) {
              final groups = provider.taskGroups;
              if (groups.isEmpty)
                return child;
              else
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) => TaskGroupWidget(
                      taskGroup: groups[index],
                    ),
                    childCount: groups.length,
                  ),
                );
            },
            child: SliverToBoxAdapter(
                child: Center(
                    child: Column(
              children: [
                Image.asset('assets/images/donkey.png'),
                Text(appLocale.emptyTaskGroupText),
                Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Text(appLocale.clickOn),
                      Icon(Icons.add),
                      Text(appLocale.toAddNewTaskGroup)
                    ]),
              ],
            ))),
          )
        ]));
  }
}
