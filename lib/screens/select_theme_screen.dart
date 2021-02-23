import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/models/app_theme.dart';
import 'package:task_meter/providers/settings_provider.dart';

class SelectThemeScreen extends StatelessWidget {
  static const routeName = '/select-theme';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Theme'),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<SettingsProvider>(
        builder: (ctx, provider, _) => ListView(
          children: [
            ListTile(
                title: Text('System '),
                onTap: () {
                  provider.updateTheme(AppTheme.System);
                }),
            ListTile(
                title: Text('Light '),
                onTap: () {
                  provider.updateTheme(AppTheme.Light);
                }),
            ListTile(
              title: Text('Dark '),
              onTap: () => provider.updateTheme(AppTheme.Dark),
            ),
          ],
        ),
      ),
    );
  }
}
