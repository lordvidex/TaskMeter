import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../domain/models/app_theme.dart';
import '../../locale/locales.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings/settings_option_screen.dart';
import '../widgets/settings/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsProvider _provider;
  AppLocalizations appLocale;

  @override
  void initState() {
    super.initState();
    _provider = context.read<SettingsProvider>();
  }

  // helper functions
  void _showSettingsOptionScreen<T>({
    @required String title,
    @required Iterable<T> options,
    @required T current,
    @required Function(T) update,
    bool hasCustomButton = false,
    Set<T> fullRowButtons,
    String Function(T) transform,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => SettingsOptionScreen<T>(
              hasCustomButton: hasCustomButton,
              update: update,
              fullRowButtons: fullRowButtons ?? {},
              current: current,
              options: options,
              valueToString: transform,
              title: title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    appLocale = AppLocalizations.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: ListTileTheme(
        tileColor: isDarkMode ? Constants.appNavyBlue : Constants.appSkyBlue,
        selectedTileColor: Constants.appBlue,
        iconColor: Constants.appBlue,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0, 14, 30, 14)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset('assets/icons/back.svg',
                        color:
                            isDarkMode ? Colors.white : Constants.appNavyBlue),
                  ),
                  Padding(
                      child: Text(
                        appLocale.settings,
                        style: TextStyle(fontSize: 24),
                      ),
                      padding: const EdgeInsets.only(top: 27, bottom: 30)),
                  SettingsSection(title: 'Tasks', tiles: [
                    SettingsTile(
                        title: appLocale.shortBreakDuration,
                        onPressed: () => _showSettingsOptionScreen<int>(
                              hasCustomButton: true,
                              update: (newValue) => _provider.updateSettings(
                                  _provider.settings.copyWith(
                                      shortBreak: Duration(minutes: newValue))),
                              current: _provider.settings.shortBreak.inMinutes,
                              title: appLocale.shortBreakDuration,
                              transform: appLocale.minutes,
                              options: Set.from([1, 2, 3, 4, 5, 8, 10])
                                ..add(_provider.settings.shortBreak.inMinutes),
                            ),
                        subtitle: appLocale
                            .minutes(_provider.settings.shortBreak.inMinutes)),
                    SettingsTile(
                        title: appLocale.longBreakDuration,
                        onPressed: () => _showSettingsOptionScreen<int>(
                              hasCustomButton: true,
                              update: (newValue) => _provider.updateSettings(
                                  _provider.settings.copyWith(
                                      longBreak: Duration(minutes: newValue))),
                              current: _provider.settings.longBreak.inMinutes,
                              title: appLocale.longBreakDuration,
                              transform: appLocale.minutes,
                              options: Set.from([5, 10, 15, 20, 25, 30, 45])
                                ..add(_provider.settings.longBreak.inMinutes),
                            ),
                        subtitle: appLocale
                            .minutes(_provider.settings.longBreak.inMinutes)),
                    SettingsTile(
                        title: appLocale.longBreakAfter,
                        onPressed: () => _showSettingsOptionScreen<int>(
                              hasCustomButton: true,
                              update: (newValue) => _provider.updateSettings(
                                  _provider.settings
                                      .copyWith(longBreakIntervals: newValue)),
                              title: appLocale.longBreakIntervals,
                              transform: appLocale.intervals,
                              current: _provider.settings.longBreakIntervals,
                              options: Set.from([1, 2, 3])
                                ..add(_provider.settings.longBreakIntervals),
                            ),
                        subtitle: appLocale
                            .intervals(_provider.settings.longBreakIntervals)),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 29.0),
                    child: SettingsSection(
                        title: 'Language and Appearance',
                        tiles: [
                          SettingsTile(
                              title: appLocale.language,
                              onPressed: () =>
                                  _showSettingsOptionScreen<String>(
                                      update: (newValue) => _provider
                                          .updateSettings(_provider.settings
                                              .copyWith(language: newValue)),
                                      title: appLocale.language,
                                      current: _provider.settings.language,
                                      options: ['en', 'ru'],
                                      transform: (string) {
                                        if (string == 'ru') {
                                          return 'Русский';
                                        }
                                        return 'English';
                                      }),
                              subtitle: _provider.settings.language == 'ru'
                                  ? 'Русский'
                                  : 'English'),
                          SettingsTile(
                              title: appLocale.appTheme,
                              onPressed: () =>
                                  _showSettingsOptionScreen<AppTheme>(
                                      update: (newValue) => _provider
                                          .updateSettings(_provider.settings
                                              .copyWith(appTheme: newValue)),
                                      fullRowButtons: {AppTheme.System},
                                      title: appLocale.appTheme,
                                      current: _provider.settings.appTheme,
                                      options: AppTheme.values,
                                      transform: appLocale.themeType),
                              subtitle:
                                  '${appLocale.themeType(_provider.settings.appTheme)} ${appLocale.theme}'),
                          SettingsTile(title: appLocale.feedback),
                          SettingsTile(title: appLocale.rate)
                        ]),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
