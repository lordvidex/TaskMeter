import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locale/locales.dart';
import '../bloc/size_bloc.dart';
import '../providers/authentication_provider.dart';
import '../widgets/task_group/task_group_analytics.dart';
import '../widgets/task_group/task_group_list.dart';
import 'authentication_screen.dart';
import 'create_task_group_screen.dart';

class TaskGroupScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  static const routeName = '/task-group';
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Consumer<AuthenticationProvider>(
        builder: (ctx, provider, _) => context.watch<SizeBloc>().isMobileScreen
            ? MobileView(
                provider: provider,
                scaffoldKey: _scaffoldKey,
                appLocale: appLocale,
              )
            : LandScapeView(
                appLocale: appLocale,
                scaffoldKey: _scaffoldKey,
                authProvider: provider,
              ));
  }
}

class MobileView extends StatelessWidget {
  const MobileView({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required this.appLocale,
    @required this.provider,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final AppLocalizations appLocale;
  final AuthenticationProvider provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(child: TaskGroupAnalytics()),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () =>
              Navigator.of(context).pushNamed(CreateTaskGroupScreen.routeName),
        ),
        body: TaskGroupListWidget(
            provider: provider,
            scaffoldKey: _scaffoldKey,
            appLocale: appLocale));
  }
}

class LandScapeView extends StatelessWidget {
  const LandScapeView({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required this.appLocale,
    @required this.authProvider,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final AppLocalizations appLocale;
  final AuthenticationProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () =>
              Navigator.of(context).pushNamed(CreateTaskGroupScreen.routeName),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 10,
              child: Container(
                width: context.read<SizeBloc>().sideBarWidth,
                height: double.infinity,
                child: authProvider.user == null
                    ? AuthenticationScreen()
                    : TaskGroupAnalytics(),
              ),
            ),
            Expanded(
                child: TaskGroupListWidget(
                    appLocale: appLocale,
                    provider: authProvider,
                    scaffoldKey: _scaffoldKey)),
          ],
        ));
  }
}