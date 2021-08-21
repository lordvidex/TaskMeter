import 'package:flutter/material.dart';

//TODO: remove unused class
class SettingsItem extends StatelessWidget {
  final String settingsText;
  final Widget? leadingWidget;
  final Widget trailingWidget;
  final Function()? onTap;
  const SettingsItem(this.settingsText, this.trailingWidget,
      {this.leadingWidget, this.onTap});
  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).brightness == Brightness.dark
        //         ? Colors.blue[300]
        //         : Colors.blue[100],
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        //   padding: const EdgeInsets.all(8),
        //   child:
        ListTile(
      onTap: onTap,
      leading: leadingWidget ?? Container(height: 40, width: 40),
      title: Text(
        settingsText,
      ),
      trailing: trailingWidget,
      //),
    );
  }
}
