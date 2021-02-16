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
      leading: leadingWidget ?? Container(height: 40, width: 40),
      title: Text(
        settingsText,
      ),
      trailing: trailingWidget,
    );
  }
}
