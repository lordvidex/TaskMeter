import 'package:flutter/cupertino.dart';
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
    _settings = Settings.fromJson(_provider.settings.toJson());
  }

  Future<bool> _back(BuildContext context) async {
    if (_provider.settings == _settings) {
      return true;
    } else {
      return showDialog<bool>(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text('Data not saved!'),
                content: RichText(
                  text: TextSpan(
                    text: 'You have some unsaved data, go back and click ',
                    children: <TextSpan>[
                      TextSpan(
                        text: String.fromCharCode(0xe64c), //<-- charCode
                        style: TextStyle(
                          fontFamily: 'MaterialIcons', //<-- fontFamily
                          fontSize: 24.0,
                        ),
                      ),
                      TextSpan(text: ' at the top-right to save!')
                    ],
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Discard'),
                    isDestructiveAction: true,
                    onPressed: () => Navigator.of(ctx).pop<bool>(true),
                  ),
                  CupertinoDialogAction(
                    child: Text('Cancel'),
                    isDefaultAction: true,
                    onPressed: () => Navigator.of(ctx).pop<bool>(false),
                  ),
                ],
                // Text(
                //   'You have some unsaved data, go back and click ${String.fromCharCode(0xe64c)} to save.',
                // ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final shortBreakWidget = DropdownButton<Duration>(
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
      value: _settings.isDarkMode ??
          (Theme.of(context).brightness == Brightness.light ? false : true),
      onChanged: (val) => setState(() {
        _settings.isDarkMode = val;
        val ? _provider.toDarkMode() : _provider.toLightMode();
      }),
    );
    return WillPopScope(
      onWillPop: () => _back(context),
      child: Scaffold(
        appBar: AppBar(title: Text('General Settings'), actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                _provider.updateSettings(_settings);
                if (await _back(context)) {
                  Navigator.of(context).pop();
                }
              })
        ]),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
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
                Icons.brightness_6_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
