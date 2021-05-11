import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locale/locales.dart';
import '../providers/authentication_provider.dart';
import '../providers/task_group_provider.dart';
import '../widgets/task_group/task_group_drawer.dart';
import '../widgets/task_group/task_group_widget.dart';
import 'authentication_screen.dart';
import 'create_task_group_screen.dart';
import 'settings_screen.dart';

class TaskGroupScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  static const routeName = '/task-group';
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Consumer<AuthenticationProvider>(
      builder: (ctx, provider, _) => Scaffold(
          key: _scaffoldKey,
          drawerEnableOpenDragGesture: false,
          drawer: TaskGroupDrawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Colors.black),
            onPressed: () => Navigator.of(context)
                .pushNamed(CreateTaskGroupScreen.routeName),
          ),
          body: RefreshIndicator(
            onRefresh: context.read<TaskGroupProvider>().loadTaskGroups,
            child: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                leading: provider.user == null
                    ? IconButton(
                        icon: Icon(Icons.login, size: 30),
                        onPressed: () => showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => AlertDialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  contentPadding: const EdgeInsets.all(0),
                                  content: AuthenticationScreen(),
                                )))
                    : IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () =>
                            _scaffoldKey.currentState.openDrawer()),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(SettingsScreen.routeName),
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
                  final groups = provider.taskGroups
                    ..retainWhere((g) => !g.isDeleted);
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
              ),
            ]),
          )),
    );
  }
}
