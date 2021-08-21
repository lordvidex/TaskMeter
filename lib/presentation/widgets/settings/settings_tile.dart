import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_meter/core/constants.dart';

/// Holds the title of the settings section and
/// the list of tiles present in this section
class SettingsSection extends StatelessWidget {
  final String? title;
  final List<Widget>? tiles;

  const SettingsSection({this.title, this.tiles});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final divider = Divider(
      height: 1,
      thickness: 1,
      color: isDarkMode ? Colors.white : Constants.appSkyBlue,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.5),
          child: Text(
            title!,
            style: TextStyle(fontSize: 14),
          ),
        ),
        divider,
        for (var item in tiles!) Column(children: [item, divider])
      ],
    );
  }
}

/// List tile customized to fit the tile design in settings screen
class SettingsTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function()? onPressed;

  const SettingsTile({this.title, this.subtitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      isThreeLine: false,
      tileColor: Colors.transparent,
      title: Text(
        title!,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: onPressed,
      trailing: Icon(
        CupertinoIcons.chevron_forward,
        size: 24,
        color: isDarkMode ? Colors.white : Constants.appNavyBlue,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
            )
          : null,
    );
  }
}
