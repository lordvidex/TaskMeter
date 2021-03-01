import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locale/locales.dart';
import '../../domain/models/app_theme.dart';
import '../providers/settings_provider.dart';

class SelectThemeScreen extends StatelessWidget {
  static const routeName = '/select-theme';
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.selectTheme),
        // shadowColor: Colors.transparent,
        // backgroundColor: Colors.transparent,
      ),
      body: Consumer<SettingsProvider>(
        builder: (ctx, provider, _) => ListView(
          children: [
            ListTile(
                title: Text(appLocale.themeType(AppTheme.System)),
                onTap: () {
                  provider.updateTheme(AppTheme.System);
                }),
            ListTile(
                title: Text(appLocale.themeType(AppTheme.Light)),
                onTap: () {
                  provider.updateTheme(AppTheme.Light);
                }),
            ListTile(
              title: Text(appLocale.themeType(AppTheme.Dark)),
              onTap: () => provider.updateTheme(AppTheme.Dark),
            ),
          ],
        ),
      ),
    );
  }
}
