import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String settingsText;
  final Widget leadingWidget;
  final Widget trailingWidget;
  const SettingsItem(this.settingsText, this.trailingWidget,
      {this.leadingWidget});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingWidget ?? Container(height: 50, width: 50),
      title: Text(
        settingsText,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: trailingWidget,
    );
  }
}
