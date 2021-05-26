import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../locale/locales.dart';
import '../../bloc/size_bloc.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/task_group_provider.dart';
import '../../screens/authentication_screen.dart';
import '../../screens/settings_screen.dart';
import 'task_group_widget.dart';

class TaskGroupListWidget extends StatelessWidget {
  const TaskGroupListWidget({
    Key key,
    @required this.provider,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required this.appLocale,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final AuthenticationProvider provider;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final AppLocalizations appLocale;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<TaskGroupProvider>().loadTaskGroups,
      child: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          leading: !context.read<SizeBloc>().isMobileScreen
              ? null
              : provider.user == null
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
                      onPressed: () => _scaffoldKey.currentState.openDrawer()),
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
              Container(
                margin: const EdgeInsets.only(top: 100, bottom: 30),
                width: 400,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: SvgPicture.asset(
                  'assets/icons/empty.svg',
                  width: 400,
                ),
              ),
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
    );
  }
}