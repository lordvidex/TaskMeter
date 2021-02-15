import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_meter/models/settings.dart';
import 'package:task_meter/widgets/settings/settings_item.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsProvider _provider;
  Settings _settings;
  @override
  void initState() {
    super.initState();
    _provider = Provider.of<SettingsProvider>(context, listen: false);
    _settings = _provider.settings;
  }

  @override
  Widget build(BuildContext context) {
    final shortBreakWidget = DropdownButton<Duration>(
        style: Theme.of(context).textTheme.bodyText2,
        value: _settings.shortBreak,
        onChanged: (x) {
          _settings.shortBreak = x;
          setState(() {});
        },
        items: List.generate(
            16,
            (x) => DropdownMenuItem<Duration>(
                value: Duration(minutes: x), child: Text('$x minutes'))));

    final longBreakWidget = DropdownButton<Duration>(
        style: Theme.of(context).textTheme.bodyText2,
        value: _settings.longBreak,
        onChanged: (x) {
          _settings.longBreak = x;
          setState(() {});
        },
        items: List.generate(
            7,
            (x) => DropdownMenuItem<Duration>(
                value: Duration(minutes: x * 5),
                child: Text('${x * 5} minutes'))));
    final longBreakIntervalWidget = DropdownButton<int>(
        style: Theme.of(context).textTheme.bodyText2,
        value: _settings.longBreakIntervals,
        onChanged: (x) {
          _settings.longBreakIntervals = x;
          setState(() {});
        },
        items: List.generate(
            9,
            (x) => DropdownMenuItem<int>(
                value: x + 2, child: Text('${x + 2} intervals'))));
    final languageWidget = DropdownButton<String>(
        style: Theme.of(context).textTheme.bodyText2,
        value: _settings.language,
        onChanged: (str) {
          //TODO: add localization logic here
        },
        items: [
          DropdownMenuItem(
            child: Text('English'),
            value: "en-US",
          ),
          DropdownMenuItem(child: Text('Русский'), value: "ru-RU")
        ]);
    final darkModeWidget = Switch.adaptive(
      value: _settings.isDarkMode,
      onChanged: (val) => setState(() {
        val ? _provider.toDarkMode() : _provider.toLightMode();
      }),
    );
    return Scaffold(
      appBar: AppBar(title: Text('General Settings')),
      body: SingleChildScrollView(
          child: Card(
        child: Column(
          children: [
            SettingsItem(
              'Short Break Duration',
              shortBreakWidget,
              leadingWidget: Icon(Icons.timer_3),
            ),
            SettingsItem(
              'Long Break Duration',
              longBreakWidget,
              leadingWidget: Icon(Icons.timer_10),
            ),
            SettingsItem(
              'Long Break after',
              longBreakIntervalWidget,
            ),
            SettingsItem(
              'Language',
              languageWidget,
              leadingWidget: Icon(Icons.translate_outlined, color: Colors.blue),
            ),
            SettingsItem(
              'Dark Mode',
              darkModeWidget,
              leadingWidget: Icon(
                Icons.brightness_4_rounded,
                color: Colors.black,
              ),
            )
          ],
        ),
      )),
    );
  }
}
