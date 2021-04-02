import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../locale/locales.dart';
import '../../domain/models/settings.dart';
import '../providers/settings_provider.dart';
import 'select_theme_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsProvider _provider;
  Settings _settings;
  AppLocalizations appLocale;
  @override
  void initState() {
    super.initState();
    _provider = context.read<SettingsProvider>();
    _settings = Settings.fromJson(_provider.settings.toJson());
  }

  Future<bool> _back(BuildContext context) async {
    if (_provider.settings == _settings) {
      return true;
    } else {
      return showDialog<bool>(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text(appLocale.dataNotSaved),
                content: RichText(
                  text: TextSpan(
                    text: appLocale.dataNotSavedDesc1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                        text: String.fromCharCode(0xe64c), //<-- charCode
                        style: TextStyle(
                          fontFamily: 'MaterialIcons', //<-- fontFamily
                          fontSize: 24.0,
                        ),
                      ),
                      TextSpan(text: appLocale.dataNotSavedDesc2)
                    ],
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text(appLocale.discard),
                    isDestructiveAction: true,
                    onPressed: () => Navigator.of(ctx).pop<bool>(true),
                  ),
                  CupertinoDialogAction(
                    child: Text(appLocale.cancel),
                    isDefaultAction: true,
                    onPressed: () => Navigator.of(ctx).pop<bool>(false),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppLocalizations singleton
    appLocale = AppLocalizations.of(context);
    // changes all leadingIcons to the same size
    Icon resizedIcon(IconData icon) => Icon(icon, size: 30);

    final shortBreakWidget = DropdownButton<Duration>(
        value: _settings.shortBreak,
        onChanged: (x) {
          _settings.shortBreak = x;
          setState(() {});
        },
        items: List.generate(
            16,
            (x) => DropdownMenuItem<Duration>(
                value: Duration(minutes: x),
                child: Text(appLocale.minutes(x)))));

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
                child: Text(appLocale.minutes(x * 5)))));
    final longBreakIntervalWidget = DropdownButton<int>(
        value: _settings.longBreakIntervals,
        onChanged: (x) {
          _settings.longBreakIntervals = x;
          setState(() {});
        },
        items: List.generate(
            9,
            (x) => DropdownMenuItem<int>(
                value: x + 2, child: Text(appLocale.intervals(x + 2)))));
    final languageWidget = DropdownButton<String>(
        value: _settings.language,
        onChanged: (str) {
          _provider.updateLanguage(str);
          setState(() {
            _settings.language = str;
          });
        },
        items: [
          DropdownMenuItem(
            child: Text('English'),
            value: 'en',
          ),
          DropdownMenuItem(
            child: Text('Русский'),
            value: 'ru',
          )
        ]);
    final themeWidget = Text(
        '${appLocale.themeType(_provider.settings.appTheme)} ${appLocale.theme}');

    return WillPopScope(
      onWillPop: () => _back(context),
      child: ListTileTheme(
        iconColor: Colors.blue[300],
        child: Scaffold(
          appBar: AppBar(title: Text(appLocale.generalSettings), actions: [
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () async {
                  _provider.updateSettings(_settings);
                  if (await _back(context)) {
                    Navigator.of(context).pop();
                  }
                })
          ]),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SettingsList(sections: [
              SettingsSection(
                title: appLocale.taskGroups,
                tiles: [
                  SettingsTile(
                    iosChevron: null,
                    titleMaxLines: 2,
                    title: appLocale.shortBreakDuration,
                    trailing: shortBreakWidget,
                    leading: resizedIcon(Icons.timer_3),
                  ),
                  SettingsTile(
                      titleMaxLines: 2,
                      iosChevron: null,
                      title: appLocale.longBreakDuration,
                      trailing: longBreakWidget,
                      leading: resizedIcon(Icons.timer_10)),
                  SettingsTile(
                    titleMaxLines: 2,
                    title: appLocale.longBreakAfter,
                    iosChevron: null,
                    leading: Container(width: 30),
                    trailing: longBreakIntervalWidget,
                  )
                ],
              ),
              SettingsSection(
                  maxLines: 2,
                  title:
                      '${appLocale.language} ${appLocale.and} ${appLocale.theme.toLowerCase()}',
                  tiles: [
                    SettingsTile(
                      title: appLocale.language,
                      leading: resizedIcon(Icons.translate_outlined),
                      trailing: languageWidget,
                      iosChevron: null,
                    ),
                    SettingsTile(
                      title: appLocale.appTheme,
                      leading: resizedIcon(Icons.brightness_6_outlined),
                      trailing: themeWidget,
                      onPressed: (_) => Navigator.of(context)
                          .pushNamed(SelectThemeScreen.routeName),
                    )
                  ]),
              SettingsSection(tiles: [
                SettingsTile(
                    title: appLocale.about,
                    onPressed: (_) => showAboutDialog(
                        context: context,
                        applicationIcon: Image.asset(
                          'assets/images/task_icon.png',
                          height: 30,
                        ),),
                    leading: resizedIcon(Icons.info_outline)),
                SettingsTile(
                    title: appLocale.feedback,
                    leading: resizedIcon(Icons.feedback)),
                SettingsTile(
                    title: appLocale.rate,
                    leading: resizedIcon(Icons.star_rate))
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
