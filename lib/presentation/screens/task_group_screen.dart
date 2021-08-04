import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locale/locales.dart';
import '../providers/authentication_provider.dart';
import '../widgets/task_group/task_group_list.dart';

class TaskGroupScreen extends StatelessWidget {
  static const routeName = '/task-group';
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
          builder: (ctx, provider, _) =>
              TaskGroupListWidget(provider: provider, appLocale: appLocale)),
    );
  }
}
